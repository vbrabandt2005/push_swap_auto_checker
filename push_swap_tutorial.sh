#!/bin/bash

echo -e "\033[1;37m##################################################\033[0m"
echo -e "\033[1;37m############## [PUSH SWAP TUTORIAL] ##############\033[0m"
echo -e "\033[1;37m##################################################\033[0m"
echo
echo -e "\033[1;37m------- [1. ONE NBR TEST] [2. RANGE TEST]  -------\033[0m"
echo -e "\033[1;37m------- [3. MINUS TEST]   [4. REMOVE LOGS] -------\033[0m"
echo -e "\033[1;37m--BONUS [5. RANGE TEST WITH BONUS_CHECKER] BONUS--\033[0m"
echo -e "\033[1;37m--BONUS [6. stack B TEST] [7. inst TEST]   BONUS--\033[0m"
echo -n "SELECT MODE : "

read MODE

if [ $MODE == 1 ]
then
	echo -n "TRGT_NUM : "

	read NUM

	echo -n "COUNT : "

	read COUNT

	make re

	TOTAL=0
	MAX=0
	MIN=999999999
	MIN_IDX=0
	MAX_IDX=0

	rm -rf ./push_swap_auto_checker
	mkdir push_swap_auto_checker
	mkdir push_swap_auto_checker/KO
	mkdir push_swap_auto_checker/OK
	mkdir push_swap_auto_checker/Error

	for (( var=1; var<=$COUNT; var++ ))
	do
		if [ $NUM -le 5000 ]
		then
			ARGS="$(seq $NUM | sort -R | xargs)"
			VALUE="$(./push_swap "$ARGS" | wc -l)"
		else
			ARGS="$(seq $NUM | sort -R | xargs | tr -s "\n" " ")"
			VALUE="$(./push_swap "$ARGS" | wc -l)"
		fi

		if [ -z $VALUE ]
		then
			echo -e "\033[31mError"
			echo -e "$VALUE\033[0m"
			echo $ARGS > ./push_swap_auto_checker/Error/testcase_Error_$NUM\_$var
			((TOTAL = $TOTAL + $VALUE))
			[ $MAX -ge $VALUE ] && MAX=$MAX || MAX_IDX=$var
			[ $VALUE -ge $MIN ] && MIN=$MIN || MIN_IDX=$var
			[ $MAX -ge $VALUE ] && MAX=$MAX || MAX=$VALUE
			[ $VALUE -ge $MIN ] && MIN=$MIN || MIN=$VALUE
		else
			echo -e "\033[32m     OK"
			echo -e "$VALUE\033[0m"
			echo $ARGS > ./push_swap_auto_checker/OK/testcase_OK_$NUM\_$var
			((TOTAL = $TOTAL + $VALUE))
			[ $MAX -ge $VALUE ] && MAX=$MAX || MAX_IDX=$var
			[ $VALUE -ge $MIN ] && MIN=$MIN || MIN_IDX=$var
			[ $MAX -ge $VALUE ] && MAX=$MAX || MAX=$VALUE
			[ $VALUE -ge $MIN ] && MIN=$MIN || MIN=$VALUE
		fi
	done
	AVG=$(expr $TOTAL / $COUNT)
elif [ $MODE == 2 ]
then
	echo -n "Enter min num : "

	read min_nbr

	echo -n "Enter max num : "

	read max_nbr

	make re

	curl -O https://cdn.intra.42.fr/document/document/23048/checker_Mac
	chmod 755 checker_Mac

	CNT_KO=0
	CNT_Error=0
	CNT_OK=0

	rm -rf ./push_swap_auto_checker
	mkdir push_swap_auto_checker
	mkdir push_swap_auto_checker/KO
	mkdir push_swap_auto_checker/OK
	mkdir push_swap_auto_checker/Error

	for (( var=$min_nbr; var<=$max_nbr; var++ ))
	do
		if [ $var -le 5000 ]
		then
			ARGS="$(seq $var | sort -R | xargs)"
			VALUE="$(./push_swap "$ARGS" | ./checker_Mac "$ARGS")"
		else
			ARGS="$(seq $var | sort -R | xargs | tr -s "\n" " ")"
			VALUE="$(./push_swap "$ARGS" | ./checker_Mac "$ARGS")"
		fi

		if [ -z $VALUE ]
		then
			echo -e "\033[31mError"
			echo -e "$var\033[0m"
			echo $ARGS > ./push_swap_auto_checker/Error/testcase_Error_$var
			((CNT_Error++))
		elif [ $VALUE == "KO" ]
		then
			echo -e "\033[31mKO"
			echo -e "$var\033[0m"
			echo $ARGS > ./push_swap_auto_checker/KO/testcase_KO_$var
			((CNT_KO++))
		elif [ $VALUE == "OK" ]
		then
			echo -e "\033[32mOK"
			echo -e "$var\033[0m"
			echo $ARGS > ./push_swap_auto_checker/OK/testcase_OK_$var
			((CNT_OK++))
		fi
	done
elif [ $MODE == 5 ]
then
	echo -n "Enter min num : "

	read min_nbr

	echo -n "Enter max num : "

	read max_nbr

	make re

	make bonus

	CNT_KO=0
	CNT_Error=0
	CNT_OK=0

	rm -rf ./push_swap_auto_checker
	mkdir push_swap_auto_checker
	mkdir push_swap_auto_checker/KO
	mkdir push_swap_auto_checker/OK
	mkdir push_swap_auto_checker/Error

	for (( var=$min_nbr; var<=$max_nbr; var++ ))
	do
		if [ $var -le 5000 ]
		then
			ARGS="$(seq $var | sort -R | xargs)"
			VALUE="$(./push_swap "$ARGS" | ./checker "$ARGS")"
		else
			ARGS="$(seq $var | sort -R | xargs | tr -s "\n" " ")"
			VALUE="$(./push_swap "$ARGS" | ./checker "$ARGS")"
		fi

		if [ -z $VALUE ]
		then
			echo -e "\033[31mError"
			echo -e "$var\033[0m"
			echo $ARGS > ./push_swap_auto_checker/Error/testcase_Error_$var
			((CNT_Error++))
		elif [ $VALUE == "KO" ]
		then
			echo -e "\033[31mKO"
			echo -e "$var\033[0m"
			echo $ARGS > ./push_swap_auto_checker/KO/testcase_KO_$var
			((CNT_KO++))
		elif [ $VALUE == "OK" ]
		then
			echo -e "\033[32mOK"
			echo -e "$var\033[0m"
			echo $ARGS > ./push_swap_auto_checker/OK/testcase_OK_$var
			((CNT_OK++))
		fi
	done
elif [ $MODE == 3 ]
then
	echo -n "Enter min num : "

	read min_nbr

	echo -n "Enter max num : "

	read max_nbr

	make re

	curl -O https://cdn.intra.42.fr/document/document/23048/checker_Mac
	chmod 755 checker_Mac

	CNT_KO=0
	CNT_Error=0
	CNT_OK=0

	rm -rf ./push_swap_auto_checker
	mkdir push_swap_auto_checker
	mkdir push_swap_auto_checker/KO
	mkdir push_swap_auto_checker/OK
	mkdir push_swap_auto_checker/Error

	((var = $max_nbr - $min_nbr))
	if [ $var -le 5000 ]
	then
		ARGS="$(seq $min_nbr $max_nbr | sort -R | xargs)"
		VALUE="$(./push_swap "$ARGS" | ./checker_Mac "$ARGS")"
	else
		ARGS="$(seq $min_nbr $max_nbr | sort -R | xargs | tr -s "\n" " ")"
		VALUE="$(./push_swap "$ARGS" | ./checker_Mac "$ARGS")"
	fi

	if [ -z $VALUE ]
	then
		echo -e "\033[31mError"
		echo $ARGS > ./push_swap_auto_checker/Error/testcase_Error_$var
		((CNT_Error++))
	elif [ $VALUE == "KO" ]
	then
		echo -e "\033[31mKO"
		echo $ARGS > ./push_swap_auto_checker/KO/testcase_KO_$var
		((CNT_KO++))
	elif [ $VALUE == "OK" ]
	then
		echo -e "\033[32mOK"
		echo $ARGS > ./push_swap_auto_checker/OK/testcase_OK_$var
		((CNT_OK++))
	fi
elif [ $MODE == 6 ]
then
	echo -n "Enter size : "

	read size

	make re

	make bonus

	CNT_KO=0
	CNT_Error=0
	CNT_OK=0

	rm -rf ./push_swap_auto_checker
	mkdir push_swap_auto_checker
	mkdir push_swap_auto_checker/KO
	mkdir push_swap_auto_checker/OK
	mkdir push_swap_auto_checker/Error

	((var = $size))
	if [ $var -le 5000 ]
	then
		ARGS="$(seq $var | xargs)"
		VALUE="$( echo "pb" | ./checker "$ARGS")"
	else
		ARGS="$(seq $var | xargs | tr -s "\n" " ")"
		VALUE="$( echo "pb" | ./checker "$ARGS")"
	fi

	if [ -z $VALUE ]
	then
		echo -e "\033[31mError"
		echo -e "$var\033[0m"
		echo $ARGS > ./push_swap_auto_checker/Error/testcase_Error_$var
		((CNT_Error++))
	elif [ $VALUE == "KO" ]
	then
		echo -e "\033[32mKO"
		echo -e "$var\033[0m"
		echo $ARGS > ./push_swap_auto_checker/KO/testcase_KO_$var
		((CNT_KO++))
	elif [ $VALUE == "OK" ]
	then
		echo -e "\033[31mOK"
		echo -e "$var\033[0m"
		echo $ARGS > ./push_swap_auto_checker/OK/testcase_OK_$var
		((CNT_OK++))
	fi
elif [ $MODE == 7 ]
then
	make re

	make bonus

	CNT_KO=0
	CNT_Error=0
	CNT_OK=0

	rm -rf ./push_swap_auto_checker
	mkdir push_swap_auto_checker
	mkdir push_swap_auto_checker/KO
	mkdir push_swap_auto_checker/OK
	mkdir push_swap_auto_checker/Error

	VALUE="$( echo -e "sb\nrb\nrrb\npa\npb\nsa\nra\nrra\npb\npa" | ./checker "1" )"

	if [ -z $VALUE ]
	then
		echo -e "\033[31mError"
		((CNT_Error++))
	elif [ $VALUE == "KO" ]
	then
		echo -e "\033[31mKO"
		((CNT_KO++))
	elif [ $VALUE == "OK" ]
	then
		echo -e "\033[32mOK"
		((CNT_OK++))
	fi
fi	

if [ $MODE == 2 ] || [ $MODE == 5 ] || [ $MODE == 3 ]
then
	echo -e	"		\033[1;32mOK : $CNT_OK\033[1;0m, \033[1;31m	KO : $CNT_KO\033[1;0m, \033[1;31m	Error : $CNT_Error"
	echo
	echo
	echo -e "		\033[42;1;37mlog files : ./push_swap_auto_checker/OK\033[0m"
	echo
	echo -e "		\033[41;1;37mlog files : ./push_swap_auto_checker/KO\033[0m"
	echo
	echo -e "		\033[41;1;37mlog files : ./push_swap_auto_checker/Error\033[0m"
	echo
elif [ $MODE == 1 ]
then
	echo -e	"		\033[1;32mAVG : $AVG\033[1;0m, \033[1;32m	MIN : $MIN  at case_$MIN_IDX\033[1;0m, \033[1;31m	MAX : $MAX  at case_$MAX_IDX"
	echo
	echo
	echo -e "		\033[42;1;37mlog files : ./push_swap_auto_checker/OK\033[0m"
	echo
elif [ $MODE == 6 ]
then
	echo -e	"		\033[1;31mOK : $CNT_OK\033[1;0m, \033[1;32m	KO : $CNT_KO\033[1;0m, \033[1;31m	Error : $CNT_Error"
	echo
	echo
	echo -e "		\033[42;1;37mlog files : ./push_swap_auto_checker/OK\033[0m"
	echo
	echo -e "		\033[41;1;37mlog files : ./push_swap_auto_checker/KO\033[0m"
	echo
	echo -e "		\033[41;1;37mlog files : ./push_swap_auto_checker/Error\033[0m"
	echo
elif [ $MODE == 7 ]
then
	echo -e	"		\033[1;32mOK : $CNT_OK\033[1;0m, \033[1;31m	KO : $CNT_KO\033[1;0m, \033[1;31m	Error : $CNT_Error"
	echo
	echo
	echo -e "		\033[42;1;37mlog files : ./push_swap_auto_checker/OK\033[0m"
	echo
	echo -e "		\033[41;1;37mlog files : ./push_swap_auto_checker/KO\033[0m"
	echo
	echo -e "		\033[41;1;37mlog files : ./push_swap_auto_checker/Error\033[0m"
	echo
elif [ $MODE == 4 ]
then
	rm -rf ./push_swap_auto_checker
	rm -f checker_Mac	
	make fclean
else
	echo
	echo -e "		\033[41;1;37mWrong MODE\033[0m"
	echo
fi
