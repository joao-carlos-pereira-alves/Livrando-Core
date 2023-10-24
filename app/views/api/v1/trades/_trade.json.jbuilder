json.extract! trade, :id, :negotiator_id, :sender_id, :status, :category, :negociation_date, :created_at, :updated_at

if trade.book.present?
  json.book do
    json.id trade.book.id
    json.title trade.book.title
    json.average_rating trade.book.average_rating
    json.author trade.book.author

    if trade.book.image.attached?
      json.image do
        json.name trade.book.image.filename.to_s if trade.book.image.filename
        json.url url_for(trade.book.image) if trade.book.image
        json.signed_id trade.book.image.signed_id if trade.book.image.signed_id
      end
    end
  end
end