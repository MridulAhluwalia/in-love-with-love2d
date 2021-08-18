#!/usr/bin/env bash
helpFunction()
{
   echo ""
   echo "Usage: $0 -o OUTPUT_PATH -n CLASS"
   echo -e "\t-o OUTPUT_PATH"
   echo -e "\t-n CLASS"
   exit 1 # Exit script after printing help
}

while getopts "o:n:" opt
do
    case "$opt" in
        o ) OUTPUT_PATH="$OPTARG" ;;
        n ) CLASS="$OPTARG" ;;
        ? ) helpFunction ;;
    esac
done

if [ -z "$CLASS" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Check class type
if [[ "$CLASS" == *State ]]
then
    TYPE='states'
    BASE='Class{__includes = BaseState}'
else
    TYPE='objects'
    BASE='Class{}'
fi

# If not OUTPUT_PATH then we use default
if [ -z "$OUTPUT_PATH" ]
then
   OUTPUT_PATH="src/${TYPE}"
fi

FILE=${OUTPUT_PATH}/${CLASS}.lua
touch ${FILE}

TEXT="""
${CLASS} = ${BASE}


function ${CLASS}:init()

end


function ${CLASS}:update(dt)

end


function ${CLASS}:render()

end
"""

# Save text to file
echo -e "${TEXT}" > ${FILE}

# Add to dependecy file
DEPENDENCY_FILE='./src/Dependencies.lua'
gsed -i -e "/-- $TYPE/ a ${OUTPUT_PATH}/${CLASS}" ${DEPENDENCY_FILE}

# Add state machine to mail file
if [[ $TYPE == 'states' ]]
then
gsed -i -e "/gStateMachine = StateMachine {/ a\
        ['${CLASS}'] = function() return ${CLASS}() end," main.lua
fi
