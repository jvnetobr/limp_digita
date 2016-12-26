#!/bin/bash
#
#
###############################################################################
#    Criado por José Vieira da Costa Neto                                     #
#    http://blog.vieira.eti.br | contato@vieira.eti.br                        #
# 									      #
#    Este programa é um software livre; você pode redistribuí-lo e/ou         #
#    modificá-lo dentro dos termos da Licença Pública Geral GNU como          #
#    publicada pela Fundação do Software Livre (FSF); na versão 3 da          #
#    Licença, ou (na sua opinião) qualquer versão.                            #
#									      #
#    Este programa é distribuído na esperança de que possa ser útil, 	      #
#    mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO	      #
#    a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a		      #
#    Licença Pública Geral GNU para maiores detalhes.			      #
#									      #
#    Você deve ter recebido uma cópia da Licença Pública Geral GNU junto      #
#    com este programa. Se não, veja <http://www.gnu.org/licenses/>.          #
#                                                                             #
#                                                                             #
###############################################################################
#
#
# Script para limpeza do Compartilhamento "Digitalizacao"
#
#

# Declarando variaveis
DIGITA="/dados/setores/Digitalizacao"
DIAS="15"
LIMP="find $DIGITA -mindepth 1 -not -name "DIGITA_*" -mtime +$DIAS -print -exec rm -rf {} \ ;"
LOG="/var/log/scripts/limp_digita.log"

# Executando limpeza
#$LIMP &> $LOG 2> /dev/null
$LIMP > $LOG

# Variaveis do e-mail de notificacao
DATA_ATUAL=`date +%Y%m%d -d -1day`
DATA_HORA=$(date +"%d-%m-%Y %H:%M:%S")
ASSUNTO="Limpeza do compartilhamento Digitalizacao"
MENSAGEM_OK="Arquivos com mais de $DIAS dias foram excluidos com sucesso em $DATA_HORA."
MENSAGEM_ERR="Nenhum arquivo com mais de $DIAS dias para exclusao em $DATA_HORA."
DESTINATARIOS="jvnetobr@gmail.com"

# Envio do e-mail de notificacao
NUM_LOGS=$(cat $LOG | wc -l)
if [ $NUM_LOGS -eq 0 ];
        then
                echo "$MENSAGEM_ERR" | mutt -s "$ASSUNTO" $DESTINATARIOS
else
                echo "$MENSAGEM_OK" | mutt -s "$ASSUNTO" $DESTINATARIOS
fi
