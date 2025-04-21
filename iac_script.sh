#!/bin/bash

# Primeiro diretório tem que ser o "/publico"!
dirs=("/publico" "/adm" "/ven" "/sec")
groups=("GRP_ADM" "GRP_VEN" "GRP_SEC")
users=("carlos"      ${groups[0]}
       "maria"       ${groups[0]}
       "joao"        ${groups[0]}

       "debora"      ${groups[1]}
       "sebastiana"  ${groups[1]}
       "roberto"     ${groups[1]}

       "josefina"    ${groups[2]}
       "amanda"      ${groups[2]}
       "rogerio"     ${groups[2]}
)
dirs_len=${#dirs[@]}
groups_len=${#groups[@]}
users_len=${#users[@]}

if [ $(($users_len % 2)) != 0 ]; then
    echo -e "[ERROR]: User without group\n"
    exit 1
fi

echo -e "Criando diretórios...\n"

for ((i = 0; i < ${dirs_len}; i++)); do
   mkdir ${dirs[i]}
done

echo ""

echo -e "Criando grupos...\n"

for ((i = 0; i < ${groups_len}; i++)); do
    groupadd ${groups[i]}
done

echo ""

echo -e "Criando usuários...\n"

for ((i = 0; i < ${users_len}; i+=2)); do
    useradd ${users[i]} -m -s /bin/bash -p '$(openssl passwd -crypt Senh4Qu@lquer)' -G ${users[i+1]}
done

echo ""

echo -e "Especificando permissões dos diretórios...\n"

for ((i = 0; i < ${groups_len}; i++)) do
    chown root:${groups[i]} ${dirs[i+1]}
    chmod 770 ${dirs[i+1]}
done

chmod 777 ${dirs[0]}

echo ""

echo -e "Fim do script!\n"
