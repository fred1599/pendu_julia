#!/usr/bin/julia

# Recherche du mot aléatoire dans le dictionnaire
function get_word(lines)
    const x = rand(1:length(lines))
    return rstrip(lines[x], '\n')
end

# chargement des mots du fichier dico.txt
function load_words(path)
    f = open(path)
    const lines = readlines(f)
    close(f)
    return lines
end

# demande une lettre à l'utilisateur
function ask_letter()
    @printf "Proposer une lettre: "
    letter = lowercase(readline()[1])
    return letter
end

# remplace la lettre proposée dans le tableau si trouvé
function replace_letter(s, a, c)
    for i=1:length(s)
        if c == s[i]
            a[i] = c
        end
    end
end

# création du mot secret et le tableau représentant ses caractères
function create_secrets(len)
    secret = "*" ^ len
    array_secret = Array{Char}(len)
    for i=1:len
        array_secret[i] = secret[i]
    end
    return secret, array_secret
end

# toutes les constantes
const path = "dico.txt"
const my_lines = load_words(path)
const word = get_word(my_lines)
const LENGTH = length(word)

# programme principal
secret, array_secret = create_secrets(LENGTH)

while secret != word
    println(secret)
    letter = ask_letter()
    replace_letter(word, array_secret, letter)
    secret = join(array_secret, "")
end

println(secret)
