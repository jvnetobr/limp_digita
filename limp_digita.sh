#!/bin/bash 
# Autor: José Vieira
#
#
###################################################################
#                                                                 #
#       TRIBUNAL DE CONTAS DOS MUNICIPIOS DO ESTADO DO CEARA      #
#                                                                 #
###################################################################
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
DESTINATARIOS="robertofreire42@gmail.com jvnetobr@gmail.com ivancrp70@gmail.com infraestrutura@tcm.ce.gov.br"
#DESTINATARIOS="jvnetobr@gmail.com"

# Envio do e-mail de notificacao
NUM_LOGS=$(cat $LOG | wc -l)
if [ $NUM_LOGS -eq 0 ];
        then
                echo "$MENSAGEM_ERR" | mutt -s "$ASSUNTO" $DESTINATARIOS
else
                echo "$MENSAGEM_OK" | mutt -s "$ASSUNTO" $DESTINATARIOS
fi
