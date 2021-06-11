#!/bin/bash


while ! [[ "$number" =~ ^[0-9]+\.?[0-9]?+\.?[0-9]?+\.?[0-9]?*$ ]]   # Check for a valid integer 
do
    echo "Lutfen bir sayi giriniz (Max: 4.100.200.300): "           # Show getting number prompt 
    read number                                                     # Get input from user
done


number=$(echo $number | sed 's/\.//g')                              # ayiricilari sil
# echo $number



fib0=1                                                              #
fib1=1                                                              # variables
arr=()                                                              #
sum=0
num=0

#########################################
# prime fonksioyonu: alidigi parametreye gore fibonacci sayisini asal ise asal olarak degilse oldugu gibi ekrana bastirir.
#########################################
prime() {

    if (( $3 == 1 ));then
        printf "f(%'.f) : %'.f (Asal)\n"  $2 $1
    elif (( $3 == 0 ));then
        printf "f(%'.f) : %'.f \n"  $2 $1
    fi
}

#########################################
# sum_digit fonksiyonu: ilk parametre olarak aldigi sayinin basamaklarinin toplamini global olan sum degiskenine atar.
#########################################
sum_digit()
{
    num=$1
    sum=0
    while ! (( $num == 0)); do
        (( sum += $num % 10 )) # basamagi al ve topla
        (( num = $num / 10))     # bir basamak azalt
    done
}

#########################################
# seven fonksiyonu: 7'nin bolunme kurallarina gore basamklarin toplamini global olan sum degiskenine atar.
#########################################
seven() 
{
    num=$1
    s=(1 3 2 -1 -3 -2 1 3 2 -1 -3 -2)
    i=0
    sum=0
    while ! (( $num == 0)); do
        (( sum += ($num % 10) * ${s[i]} ))  # basamagi al ve topla
        (( num = $num / 10))                # bir basamak azalt
        (( i = $i + 1 ))
    done 

}
#########################################
# eleven fonksiyonu: 11'in bolunme kurallarina gore basamklarin toplamini global olan sum degiskenine atar.
#########################################
eleven() 
{
    num=$1
    i=-1
    sum=0
    while ! (( $num == 0)); do
        (( i = $i * -1 ))
        if (( $i < 0));then
            (( neg += ($num % 10) *  $i)) 
        else
            (( pos += ($num % 10) *  $i))
        fi 
        (( num = $num / 10))  
    done
    
    # ((sum = $pos + $neg))
    sum=pos+neg
    if (( $sum < 0 ));then           # sonuc negatif ise
        (( sum = $pos + $neg + 11 ))
    fi
}

#########################################
# thirteen fonksiyonu: 13'un bolunme kuralına gore 
#  10a+b
#  a+4b islemlerini gerceklestirir ve a-5b mod 13 sonucunu global olan num degiskenine kopyalar.
#########################################
thirteen()
{
    (( a = $1 / 10 ))
    (( b = $1 % 10 ))
    num=$((($a + (4 * $b)) % 13 )) 
}

#########################################
# thirteen fonksiyonu: 17'nin bolunme kuralına gore 
#  10a+b
#  a-5b islemlerini gerceklestirir ve a+4b mod 17 sonucunu global olan num degiskenine kopyalar.
#########################################
seventeen()
{
    (( a = $1 / 10 ))
    (( b = $1 % 10 ))
    num=$((($a - (5 * $b)) % 17 )) 
}

#########################################
# thirteen fonksiyonu: 19'un bolunme kuralına gore 
#  10a+b
#  a+2b islemlerini gerceklestirir ve a+2b mod 19 sonucunu global olan num degiskenine kopyalar.
#########################################
nineteen()
{
    (( a = $1 / 10 ))
    (( b = $1 % 10 ))
    num=$((($a + (2 * $b)) % 19 )) 
}

#########################################
# thirteen fonksiyonu: 23'un bolunme kuralına gore 
#  10a+b
#  a+7b islemlerini gerceklestirir ve a+7b mod 23 sonucunu global olan num degiskenine kopyalar.
#########################################
yirmiuc()
{
    (( a = $1 / 10 ))
    (( b = $1 % 10 ))
    num=$((($a + (7 * $b)) % 23 )) 
}

#########################################
#########################################
isPrime() {
    n=$1
    temp=29   # temp
    d=$(echo "sqrt($1)" | bc)

    if [ $1 -eq 1 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 2 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 3 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 5 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 7 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 11 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 13 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 17 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 19 ];then
        prime $1 $2 1
        # p=1
    elif  [ $1 -eq 23 ];then
        prime $1 $2 1
        # p=1
    else
        while true; do
            # for 2
            # echo "While"
            np=0
            if ((${n: -1} % 2 == 0)); then
                # nprime $1 $2
                np=1
                # break
            fi
            # for 3
            sum_digit $1
            if (($sum % 3 == 0)); then
                # nprime $1 $2
                np=1
                # break
            fi
            # for 5
            if ((${n: -1} == 0)) || ((${n: -1} == 5)); then
                # nprime $1 $2
                # break
                np=1
                # break
            fi

            # for 7
            sum=0
            seven $n
            if (($sum % 7 == 0)); then
                # nprime $1 $2
                np=1
                # break
                # break
            fi

            # for 11
            sum=0
            eleven $n
            if (($sum % 11 == 0)); then
                # nprime $1 $2
                np=1
                # break
            fi

            # for 13
            num=0
            thirteen $n
            if (( $num == 0 ));then
                # nprime $1 $2
                # break
                np=1

            fi
            # for 17
            num=0
            seventeen $n
            if (( $num == 0 ));then
                # nprime $1 $
                np=1
                # break
            fi            
            # for 19
            num=0
            nineteen $n
            if (( $num == 0 ));then
                # nprime $1 $2
                np=1
                # break
            fi

            # for 23
            num=0
            yirmiuc $n
            if (( $num == 0 ));then
                np=1
            fi

            if (( $n == $1 )) && (( $np == 1 ));then # eger sayi ilk sefer not prime olarak belirlenmisse while'den cik yoksa
                prime $1 $2 0
                break
            elif (( $d >= $temp ));then
                if (( $np == 0 )) && (( $1 % $temp == 0 )) && (( $temp != $1 ));then # eger $1  prime olan temp deigskenine bolunuyorsa
                    prime $1 $2 0
                    np=1
                    break
                fi
                if (( $1 == $temp )) && (( $np == 0 )); then
                    prime $1 $2 1
                    p=1
                    break
                fi

                (( temp = $temp + 2))
                (( n = $temp ))
                # np=0
            else
                prime $1 $2 1
                # p=1
                break
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
        # echo "ok"
        arr+=( 1 ) # f(0)
        arr+=( 1 ) # f(1)
        # echo "1"
    fi
    if (( $last == 0  ))
    then
        arr+=(1) # f(0)
    fi

    # && (( ($fib1 + $fib1) < $last ))
    while (( $fib1 < $last )) && (( ($fib1 + $fib0) < $last ))
    do
        # echo "ok"
        (( rs = $fib0 + $fib1 ))
        # echo $rs
        fib0=$fib1
        fib1=$rs
        arr+=( $rs ) # arr dizisine ekle
    done
}

# fib 1250350450
# fib 4100200300
# fib 6
fib $number
sayac=${#arr[@]}
let "sayac=$sayac-1"
# echo $sayac

while ((  $sayac >= 0 ))  
do
    # printf "f(%'.f) : %'.f\n"  $sayac ${arr[sayac]}
    isPrime ${arr[sayac]}  $sayac
    # echo "${arr[sayac]}"
    (( sayac = $sayac - 1 ))
done





