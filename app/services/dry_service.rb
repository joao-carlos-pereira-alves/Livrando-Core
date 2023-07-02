class DryService
  require 'dry/monads/result'
  require 'dry/matcher/result_matcher'
  include Dry::Monads[:result, :do]

  def self.call(*args, &block)
    result = new(*args, &block).call

    # Log dos failures results no caso de producao, nao passamos informacoes no corpo da request por motivo de seguranca
    if ENV['FAILURE_LOG'] && result.failure?
      Rails.logger.info "\n
                          ############### Failure Service #{self} ###############\n
                          step: #{result.failure.first}\n
                          reason: #{result.failure.last}\n"
    end

    # Adiciona mensagem de erro para ambiente de desenvolvimento mas nao para producao
    result.failure << {} if Rails.env.production? && result.failure?

    if !Rails.env.production? && result.failure?
      result.failure << { errors: { step: result.failure.first, failure: result.failure.last } }
    end

    # Esse retorno permite ser utilizado o padrao do-&block no controller utilizando o dry-matcher
    if block_given?
      Dry::Matcher::ResultMatcher.call(result, &block)
    else
      result
    end
  end

  private

  # Metodos que permitem a construcao de Contratos dinamicos dentro dos Services objects
  def parameters(&block)
    @parameters = block
  end

  def rules(&block)
    @rules = block
  end

  def validator
    local_parameters = @parameters
    local_rules      = @rules

    @validator ||= Class.new(::BaseContract) do
      params do
        instance_exec(&local_parameters)
      end
      instance_exec(&local_rules) if local_rules
    end.new
  end

  def validate(data)
    result = validator.call(data.to_h)
    return Failure[:validate_params, result.errors.to_h] if result.failure?

    Success(result.to_h)
  end
end