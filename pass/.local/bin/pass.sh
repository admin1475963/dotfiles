password_store="$HOME/.password-store"

type=$1

if [ -z $type ]
then
    type=$( ls ~/.password-store/personal | dmenu )
fi

if [ -n $type ]
then
    if [ $type = "otps" ]
    then
        otp="otp"
    else
        otp=""
    fi

    items=$( ls "$password_store/personal/$type" )

    items=$( echo "$items" | cut -f 1 -d '.' )

    target=$( echo "$items" | bemenu )

    pass $otp -c "personal/$type/$target"
fi
