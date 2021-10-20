#!/bin/bash

#########################################
#					                    #
#		        PROVISION	        	#
#					                    #
#########################################

#Alterando issue e issue.net

echo "{{             Servidor de Produção - Acesso Restrito                  }}" > $HOME/issue_example
cat $HOME/issue_example | sudo tee /etc/issue | sudo tee /etc/issue.net 1> /dev/null

#Alterando o motd

echo "{{          Seja Cauteloso - Suas Ações estão sendo Monitoradas        }}" > $HOME/motd_example
cat $HOME/motd_example | sudo tee /etc/motd 1> /dev/null

#Adicionando alias para o ls --color
#Utilizando o tee -a para acrescenter o alias no bashrc

echo 'alias ls="ls --color"' | sudo tee -a /etc/bash.bashrc 1> /dev/null

#Atualizando pacotes de dependencias

sudo zypper --non-interactive update

#Instalando pacotes

#################################
#          1 .LSB-Release	    #
#	       2. Nginx		        #
#	       3. Htop		        #
#################################


sudo zypper --non-interactive install lsb-release nginx htop

#Verificando e alterando o nginx

if [ $(sudo rpm -qa | grep nginx) ]; then

    sudo systemctl enable nginx
    grep -o "^[^#]*" /etc/nginx/nginx.conf.default | uniq | sudo tee /etc/nginx/nginx.conf 1> /dev/null
    echo "<h1>xD</h1>" | sudo tee /srv/www/htdocs/index.html 1> /dev/null

    sudo systemctl start nginx

    if [ $(sudo systemctl is-active nginx) == 'active' ]; then
        echo -e "OK"
    else
        echo -e "Nginx disable, verificar!!"
    fi

else
    echo -e "O pacote não existe, contate o adminstrador do sistema para realizar a configuração"
fi