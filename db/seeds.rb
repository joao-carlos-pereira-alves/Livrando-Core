# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Categories

Category.destroy_all

categories = [
  "Ficção Científica",
  "Fantasia",
  "Romance",
  "Mistério",
  "Suspense",
  "Aventura",
  "Histórico",
  "Policial",
  "Não Ficção",
  "Autoajuda",
  "Biografia",
  "História",
  "Religião",
  "Filosofia",
  "Ciência",
  "Tecnologia",
  "Arte",
  "Culinária",
  "Viagens",
  "Esportes",
  "Quadrinhos",
  "Poesia",
  "Teatro",
  "Drama",
  "Horror",
  "Fábula",
  "Mitologia",
  "Autores Clássicos",
  "Jornalismo",
  "Negócios",
  "Educação",
  "Saúde",
  "Autoajuda",
  "Política",
  "Psicologia",
  "Ensaio",
  "Contos",
  "Jovem Adulto",
  "Infantil",
  "Livros Ilustrados"
]

# Criação das categorias
categories.each do |category|
  Category.create(name: category)
  puts "Categoria '#{category}' criada."
end

puts "Seeds de categorias concluídos."