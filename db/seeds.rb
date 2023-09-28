# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Categories

User.create(
  id: 1,
  email: 'teste@gmail.com',
  cpf: '88848249906',
  name: 'João Carlos',
  birth_date: '01/01/2000',
  phone: '61986542184',
  password: 123456
)

User.create(
  id: 3,
  email: 'teste2@gmail.com',
  cpf: '14670263609',
  name: 'João Carlos 2',
  birth_date: '01/01/2000',
  phone: '61986542185',
  password: 123456
)

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

first_category_id = Category.first.id

# Livro 1
Book.create!(
  added_by_id: 1,
  responsible_id: 3,
  author: "Autor 1",
  title: "Livro 1",
  description: "Descrição do Livro 1",
  status: 1, # Status 1 representa 'Disponível'
  genre: nil, # Gênero 3 representa 'Ficção Científica'
  isbn: "978-1234567890",
  publishing_company: "Editora A",
  publication_year: "2020",
  language: 2, # Idioma 2 representa 'Inglês'
  amount: 5,
  book_categories_attributes: [
    {
      category_id: first_category_id
    }
  ]
)

# Livro 2
Book.create!(
  added_by_id: 1,
  responsible_id: 3,
  author: "Autor 2",
  title: "Livro 2",
  description: "Descrição do Livro 2",
  status: 1,
  genre: nil, # Gênero 2 representa 'Romance'
  isbn: "978-0987654321",
  publishing_company: "Editora B",
  publication_year: "2019",
  language: 1, # Idioma 1 representa 'Português'
  amount: 3,
  book_categories_attributes: [
    {
      category_id: first_category_id
    }
  ]
)

# Livro 3
Book.create!(
  added_by_id: 1,
  responsible_id: 3,
  author: "Autor 3",
  title: "Livro 3",
  description: "Descrição do Livro 3",
  status: 0, # Status 0 representa 'Indisponível'
  genre: nil, # Gênero 4 representa 'Fantasia'
  isbn: "978-9876543210",
  publishing_company: "Editora C",
  publication_year: "2021",
  language: 1,
  amount: 2,
  book_categories_attributes: [
    {
      category_id: first_category_id
    }
  ]
)

# Livro 4
Book.create!(
  added_by_id: 1,
  responsible_id: 3,
  author: "Autor 4",
  title: "Livro 4",
  description: "Descrição do Livro 4",
  status: 1,
  genre: nil, # Gênero 1 representa 'Mistério'
  isbn: "978-5432109876",
  publishing_company: "Editora D",
  publication_year: "2018",
  language: 0, # Idioma 0 representa 'Outro'
  amount: 4,
  book_categories_attributes: [
    {
      category_id: first_category_id
    }
  ]
)

# Livro 5
Book.create!(
  added_by_id: 1,
  responsible_id: 3,
  author: "Autor 5",
  title: "Livro 5",
  description: "Descrição do Livro 5",
  status: 1,
  genre: nil,
  isbn: "978-1357924680",
  publishing_company: "Editora E",
  publication_year: "2017",
  language: 1,
  amount: 1,
  book_categories_attributes: [
    {
      category_id: first_category_id
    }
  ]
)

# Livro 6
Book.create!(
  added_by_id: 1,
  responsible_id: 3,
  author: "Autor 6",
  title: "Livro 6",
  description: "Descrição do Livro 6",
  status: 1,
  genre: nil,
  isbn: "978-9876543210",
  publishing_company: "Editora F",
  publication_year: "2022",
  language: 3, # Idioma 3 representa 'Espanhol'
  amount: 6,
  book_categories_attributes: [
    {
      category_id: first_category_id
    }
  ]
)

# Livro 7
Book.create!(
  added_by_id: 1,
  responsible_id: 3,
  author: "Autor 7",
  title: "Livro 7",
  description: "Descrição do Livro 7",
  status: 1,
  genre: nil,
  isbn: "978-5678901234",
  publishing_company: "Editora G",
  publication_year: "2016",
  language: 1,
  amount: 2,
  book_categories_attributes: [
    {
      category_id: first_category_id
    }
  ]
)