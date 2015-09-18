#bin/bash
resultado=/tmp/resultado
canciones=/tmp/canciones
enlaces=/tmp/enlaces
titulos=/tmp/titulos
#Pedimos al usuario el titulo de la canción.
echo "Introduce el título de la canción o del artista:" 
read TITULO

if [ ! -d "goear" ]
then
	mkdir goear
fi
#Descargamos el PHP correspondiente al título.
wget http://goear.com/search.php?q="$TITULO" -O $resultado

#La línea 130 contiene todos los enlaces a goear... de risa pero bueno.
head -130 $resultado | tail -1 > $canciones

#Mediante ER, obtenemos una lista de canciones y una lista de enlaces.
egrep -o 'listen/......./[^"]*' $canciones > $enlaces
egrep -o '"Escuchar[^"]*' $canciones > $titulos

#Mostramos al usuario los que ha encontrado en la primera página.
Linea=1
cat $titulos | while read line;
	do {
	        echo $Linea: ${line:9}
		let 'Linea += 1'
        }
        done

#Si no encuentra nada, sale.
CONDICION=`wc -l $titulos | awk '{print $1}'`
if [ $CONDICION == 0 ]; then
	echo "No hay resultados. Prueba buscando otra cosa."
	rm $resultado $canciones $enlaces $titulos
	exit
fi

#Leemos qué canción quiere el usuario bajarse.
echo "¿Cuál te quieres bajar? Indica el número:"
read NUMERO

#Concatenamos http://www.goear.com con el contenido de aBajar.txt.
#PD: Alguien sabe hacerlo de manera más sencilla?
GOEAR=http://www.goear.com/
aBajar=`head -$NUMERO $enlaces | tail -1`
for LISTEN in $aBajar
do
	ENLACE=${GOEAR}${LISTEN}
done
echo $ENLACE

#A partir de aquí el script no es mío, pero es muy sencillo de leer.
fileid=`echo $ENLACE | cut -d '/' -f 5`
xmlurl="http://www.goear.com/tracker758.php?f="$fileid
infoline=`wget -qO- $xmlurl | grep ".mp3"`
mp3url=`echo $infoline | cut -d '"' -f6`
artist=`echo $infoline | cut -d '"' -f10`
title=`echo $infoline | cut -d '"' -f12`
filename=goear/"$artist-$title.mp3"
wget $mp3url -O "$filename"
rm $resultado $canciones $enlaces $titulos

echo "¿Quieres reproducirla?[Y/n]"
read RES
if [ -z "$RES" -o "$RES" = "Y" -o "$RES" = "y" ];then
	mplayer  "$filename";
fi;
