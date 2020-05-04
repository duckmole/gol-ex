# Objectifs

- Faire un dojo avec de la communication inter process
- Mettre en place un superviseur

# Initialisation du projet

## Creation du projet

- Creation projet Elixir : `mix new gol --module Gol`
- `cd gol`
- git `init`

## tests

`mix test`
`mix format mix.exs "lib/**/*.{ex,exs}" "test/**/*.{ex,exs}"`

# Une cellule

règles :
- une cellule morte possédant exactement trois voisines vivantes devient vivante (elle naît) ;
- une cellule vivante possédant deux ou trois voisines vivantes le reste, sinon elle meurt.

On va utiliser un process par cellule même si un cellule est vivant le process tournera toujours.
Voir la doc : https://hexdocs.pm/elixir/Process.html#content

## Au bout de 200ms met à jour mon état en fonction des état réçu

### Une cellule peut envoyer son état

Sur la réception d'une message de type `state` la cellule retourne son état.
Il y a 2 états possibles :
- `alive`
- `dead`

On doit démarrer un process et revoyer un message sur reception de `state`

`mix new . --module Cell`

Tests
- Retourner un état
- Créer un process
- Retourner l'état avec le process

### Une cellule peut modifier son état

Au bout de 200ms si une cellule ne recoit rien,
- elle change d'état en fonction du nombre de cellule vivante dans son voisinage
- elle prévient son voisionnage de son changement d'état.
