*** Settings ***
Library    RequestsLibrary
Library    String
*** Variables ***
${ROST}    https://dummyjson.com/

###Rotas
${ADD_NEW_PRODUCT}   products/add

*** Keywords ***
Adicionar produto  
    [Arguments]  ${title}   ${description}  ${price}   ${brand}
    &{header}    Create Dictionary    Content-type=application/json

    &{body}   Create Dictionary    title=${title} description=${description} price=${price} brand=${brand}

    POST  url=${ROST}/${ADD_NEW_PRODUCT}   headers=&{header}   json=&{body}


*** Test Cases ***
TC01 - Adicionar produto 
    Adicionar produto  title=Xiomi  description=Celular original da xiomi  price=1987,99  brand=Samgsung