#!/bin/bash

###
#       YAZAR         
# Hossein MOHAMMADI   -
###


while ! [[ "$number" =~ ^[0-9]+\.?[0-9]?+\.?[0-9]?+\.?[0-9]?*$ ]]   # Check for a valid integer 
do
    echo "Lutfen bir sayi giriniz (Max: 4.100.200.300): "           # Show getting number prompt 
    read number                                                     # Get input from user
done


number=$(echo $number | sed 's/\.//g')                              # ayiricilari sil
# echo $number

fib0=1                                                              # n-1'inci fibonacci sayisini tutan degisken
fib1=1                                                              # n'inci fibonacci sayisini tutan degisken                        variables
arr=()                                                              # Fibonacci sayılarını tutan dizi
sum=0                                                               # rakamların toplamını tutacak değişken
num=0                                                               # bölünebilme kurallarında a*n(-/+)b sonuclarını tutan değişken
# asallar=()                                                          # 

#########################################
# prime fonksioyonu: Aldığı parametrelere göre fibonacci sayisını asal ise asal olarak, degilse oldugu gibi ekrana bastırır.
# $1: ilgili fibonacci sayısı
# $2: Kaçıncı Fibınaccı ?
# $3: Asallık
#########################################
prime() {
    

    if (( $3 == 1 ));then                           # asal olarak mı kabul edilmiş ?
        printf "F(%'.f) : %'.f (Asal)\n"  $2 $1     # Asal olarak bastır
    elif (( $3 == 0 ));then                         # yoksa
        printf "F(%'.f) : %'.f \n"  $2 $1           # asal değil olarak ekrana yazdır.
    fi
}

#########################################
# sum_digit fonksiyonu: ilk parametre olarak aldığı sayının basamaklarının toplamını global olan sum değişkenine atar.
#########################################
sum_digit()
{
    num=$1
    sum=0
    while ! (( $num == 0)); do   # Sayı sıfır olana dek 
        (( sum += $num % 10 ))   # Basamağı al ve topla.
        (( num = $num / 10))     # Bir basamak azalt
    done
}

#########################################
# seven fonksiyonu: 7'nin bölünebilme kuralına göre basamakların toplamını global olan sum değişkenine atar.
#########################################
seven() 
{
    num=$1
    s=(1 3 2 -1 -3 -2 1 3 2 -1 -3 -2)       # (Girdinin sınırlı olduğu için) 7'nin bölünebilme kuralı için çarpanları tutan dizi
    i=0                                     # s dizisi için index görevini görecek değişken
    sum=0                                   # Basamakların çarpanları ile toplamını tutacak değişken
    while ! (( $num == 0)); do              # Sayı sıfır olana dek
        (( sum += ($num % 10) * ${s[i]} ))  # basamagi al ve topla
        (( num = $num / 10))                # bir basamak azalt
        (( i = $i + 1 ))
    done 

}
#########################################
# eleven fonksiyonu: 11'in bölünebilme kurallarina göre basamklarin toplamini global olan sum değişkenine atar.
#########################################
eleven() 
{
    num=$1
    i=-1                                   # Basamak çarpanları için tanımlanmış
    sum=0
    while ! (( $num == 0)); do
        (( i = $i * -1 ))                  # Tek basamk ise -1 çift ise +1
        if (( $i < 0));then                # tek basamak == negatif ise
            (( neg += ($num % 10) *  $i))  # negatifleri topla
        else
            (( pos += ($num % 10) *  $i))  # yoksa pozitif olarak kabul et ve pozitiflere ekle.
        fi 
        (( num = $num / 10))               # bir basamak azalt.
    done
    
    sum=pos+neg
    if (( $sum < 0 ));then                 # sonuc negatif ise
        (( sum = $pos + $neg + 11 ))
    fi
}

#########################################
# thirteen fonksiyonu: 13'un bölünebilme kuralına göre 
#  10a+b
#  a+4b islemlerini gerceklestirir ve a-5b mod 13 sonucunu global olan num değişkenine kopyalar.
#########################################
thirteen()
{
    (( a = $1 / 10 ))                  # a
    (( b = $1 % 10 ))                  # b
    num=$((($a + (4 * $b)) % 13 ))     # a+4b
}

#########################################
# seventeen fonksiyonu: 17'nin bölünebilme kuralına göre 
#  10a+b
#  a-5b islemlerini gerceklestirir ve a+4b mod 17 sonucunu global olan num değişkenine kopyalar.
#########################################
seventeen()
{
    (( a = $1 / 10 ))                  # a
    (( b = $1 % 10 ))                  # b
    num=$((($a - (5 * $b)) % 17 ))     # a-5b
}

#########################################
# nineteen fonksiyonu: 19'un bölünebilme kuralına göre 
#  10a+b
#  a+2b islemlerini gerceklestirir ve a+2b mod 19 sonucunu global olan num değişkenine kopyalar.
#########################################
nineteen()
{
    (( a = $1 / 10 ))                  # a
    (( b = $1 % 10 ))                  # b
    num=$((($a + (2 * $b)) % 19 ))     # a+2b
}

#########################################
# twentyThree fonksiyonu: 23'un bölünebilme kuralına göre 
#  10a+b
#  a+7b islemlerini gercekleştirir ve a+7b mod 23 sonucunu global olan num değişkenine kopyalar.
#########################################
twentyThree()
{
    (( a = $1 / 10 ))                   # a
    (( b = $1 % 10 ))                   # b
    num=$((($a + (7 * $b)) % 23 ))      # a+7b
}
###
# NOT: bazı kurallar için fonksiyon yazılmadı. Örneğin 6: sebep: 2 ve 3 sayıları kontrlü yapıldığı için 6 kuralına bakmaya gerek kalmaz.
###



#########################################
# isPrime() fonksiyonu: parametre olarak aldığı sayının asallığını kontrol eder.
# Aynı zamanda eğer sayı asal olarak değerlendirilirse ilgili sayıyı bastırmak
# üzere prime() fonksiyonunu çağırır. 
#########################################
isPrime() {
    n=$1
    temp=29                                                                             # temp
    d=$(echo "sqrt($1)" | bc)                                                           # ilgli Fib. sayısının kare kökünü hesapla ve d değikenine kopyala.

    if [ $1 -eq 1 ];then                                                                # 
        prime $1 $2 1                                                                   #   
    elif  [ $1 -eq 2 ];then                                                             #
        prime $1 $2 1                                                                   #
    elif  [ $1 -eq 3 ];then                                                             #
        prime $1 $2 1                                                                   #
    elif  [ $1 -eq 5 ];then                                                             #
        prime $1 $2 1                                                                   #
    elif  [ $1 -eq 7 ];then                                                             #    
        prime $1 $2 1                                                                   # ilgili Fibonacci sayisi kurali bulunan sayilardan biri ise asal olarak ekrana yazdir.
    elif  [ $1 -eq 11 ];then                                                            #
        prime $1 $2 1                                                                   #
    elif  [ $1 -eq 13 ];then                                                            #
        prime $1 $2 1                                                                   #
    elif  [ $1 -eq 17 ];then                                                            #
        prime $1 $2 1                                                                   #
    elif  [ $1 -eq 19 ];then                                                            #
        prime $1 $2 1                                                                   #
    elif  [ $1 -eq 23 ];then                                                            #
        prime $1 $2 1                                                                   #
    else                                                                                # Fibonacci sayisi, kurali bulunan sayilarin disinda ise
        while true; do

            np=0
            # for 2
            if ((${n: -1} % 2 == 0)); then                                              # son basamak çift mi ?
                np=1                                                                    # Fibonacci sayısı asal değildir. 
            fi

            # for 3                                                                     #
            sum_digit $1                                                                #
            if (($sum % 3 == 0)); then                                                  # Basamakların toplamı üçün katı ise
                np=1                                                                    # Fibonacci sayısı asal değildir.  
            fi

            # for 5
            if ((${n: -1} == 0)) || ((${n: -1} == 5)); then                             # Son basamaklar 0 ya da 5 ise 
                np=1                                                                    # Fibonacci sayısı asal değildir.
            fi

            # for 7
            sum=0               
            seven $n    
            if (($sum % 7 == 0)); then                                                  # 7'nin bölünebilme kuralından dönen sonuç 7'ye bölünüyorsa
                np=1                                                                    # Fibonacci sayısı asal değildir.
            fi

            # for 11
            sum=0
            eleven $n
            if (($sum % 11 == 0)); then                                                
                np=1
            fi

            # for 13
            num=0
            thirteen $n
            if (( $num == 0 ));then
                np=1

            fi

            # for 17
            num=0
            seventeen $n
            if (( $num == 0 ));then
                np=1
            fi

            # for 19
            num=0
            nineteen $n
            if (( $num == 0 ));then
                np=1
            fi

            # for 23
            num=0
            twentyThree $n
            if (( $num == 0 ));then
                np=1
            fi

            if (( $n == $1 )) && (( $np == 1 ));then                                 # eger sayi ilk sefer not prime olarak belirlenmisse while'den cik,
                prime $1 $2 0                                                        # Asal degil olarak yazdir
                break                                                                # Donguden cik
            elif (( $d >= $temp ));then                                              # yoksa temp sayisi, ilgili Fibonacci sayisinin kare kokunden kucuk oldugu surece asagidaki ifadeleri calistir. 
                if (( $np == 0 )) && (( $1 % $temp == 0 )) && (( $temp != $1 ));then # eger $1  prime olan temp deigskenine bolunuyorsa
                    prime $1 $2 0                                                    # asal degil olarak ekrana yazdir
                    break                                                            # donguden cik
                fi

                #  Önerme : n > 1, n∈ Ν ve n ≠ 4 olsun . Eğer Fn asal ise n asaldır. 
                #  Önerme2: Herhangi bir sayı kare kökünden daha küçük sayılara bölünemiyorsa şayet asaldır.(bu kodda uygulanmış olan)
                # Kendi Algoritmam(denedim ancak runtime önerme 2'ye göre daha fazla olduğunu farkettim.):
                    # asallar diye bir dizi tanimla birinci elemanı 29 olacak şekilde
                    # 29'dan başlayan bir geçici değişken tanımla
                    # ilgili Fib.sayisi eğer asallığı belli değilse ve 25'den büyükse
                    # asallar dizisindeki elemanların ilgili Fib. sayısına bölünüp bölünmediğini kontrol et. bölünürse asal değildir yoksa
                    # geçeici değişkeni 2'şer 2'şer arttır ve bölünebilme kurallarına uygula.
                    # Her döngüde ilgili Fib. sayısı dizideki elemanlara böl eğer bölünürse asal değil olarak yazdır yoksa döngü ilgili Fib. sayısının kare kökü kadar dönsün. 
                    # Ayrıca döngü devam ederken kontrol edilip asal olarak kabul edilmiş sayıları diziye ekle.



                
                (( temp = $temp + 2))                                                 # (temp: 29) 2 eklemenin sebebi -> Eger Fibonacci sayisi cift bir sayiya bolunecek olsaydi 2'ye de bolunebilirdi.
                (( n = $temp ))                                                       # temp'i n degiskenine kopyala. -> kurallar n degiskeni uzerinden gerceklestirildigi icin.
            else                                                                      # ilgili Fib. sayısı kare kökünden önceki sayılara bölünmediyse 
                prime $1 $2 1                                                         # asal olarak kabul et
                break                                                                 # döngüden çık.
            fi
        done
    fi
}


#########################################
# fib fonksiyonu: parametere olarak aldigi sayiya kadar olan tum Fibonacci
# sayilarini global olan arr dizisine atar.
#########################################
fib() {

    last=$1
    fib0=0
    fib1=1
    if (( $last >= 1 ))
    then 
        arr+=( 1 ) # f(0)
        arr+=( 1 ) # f(1)
    fi
    if (( $last == 0  ))
    then
        arr+=(1) # f(0)
    fi

    # && (( ($fib1 + $fib1) < $last ))
    while (( $fib1 < $last )) && (( ($fib1 + $fib0) < $last ))       # kullanıcının girdiği sayıya gelene dek ...
    do
        (( rs = $fib0 + $fib1 ))    # F(n-1)+F(n-2)
        fib0=$fib1                  # önceki fib. sayısını sakla.
        fib1=$rs                    # yeni Fib. sayısını sakla.
        arr+=( $rs )                # arr dizisine ekle
    done
}

fib $number                         # Girdi değerine kadar Fibonacci sayılarını hesapla.
sayac=${#arr[@]}                    # Fibonacci sayılarını tutan dizinin uzunluğunu sayac değişkenine ata.
let "sayac=$sayac-1"                # dizi boyutundan bir azalt.
# echo $sayac

while ((  $sayac >= 0 ))            # Sayac sıfır olana değin ...
do
    isPrime ${arr[sayac]}  $sayac   # ilgili Fibonacci sayısı için asallığı kontrol eden fonksiyonu Çağır.
    (( sayac = $sayac - 1 ))        # Sayacı bir azalt.
done
