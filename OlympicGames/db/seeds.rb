# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#3.times do 
#	athlete = Athlete.create({nome: Faker::Name.name})
#	competition = Competition.create({nome: Faker::Name.name, encerrada:false, tem_limite:false, limite:0})
#end

competition = Competition.new();

Athlete.create({nome: "atleta 1"})
Competition.create({nome: "competicao 1", encerrada:false, tem_limite:false, limite:0, ordenacao:competition.ordenacao_asc })

Athlete.create({nome: "atleta 2"})
Competition.create({nome: "competicao 2", encerrada:true, tem_limite:false, limite:0, ordenacao:competition.ordenacao_desc })

Athlete.create({nome: "atleta 3"})
Competition.create({nome: "competicao 3 Dardo", encerrada:false, tem_limite:false, limite:3, ordenacao:competition.ordenacao_desc })