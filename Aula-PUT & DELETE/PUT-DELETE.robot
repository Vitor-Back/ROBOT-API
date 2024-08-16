*** Settings ***
Library    RequestsLibrary
Library    String

*** Variables ***
${ROST}    https://dummyjson.com/

###Rotas
${UPDATE_PRODUCT}   products/id-produto
${DELETE_PRODUCT}    products/id-produto-delete

*** Keywords ***
Arualizar produto  
    [Arguments]  ${id}   ${title}   ${description}  ${price}   ${brand}    ${Description}=none
    &{header}    Create Dictionary    Content-type=application/json

    &{body}   Create Dictionary    title=${title} description=${description} price=${price} brand=${brand}

    ${UPDATE_PRODUCT}=  Replace String   ${UPDATE_PRODUCT}    id-produto    ${id}
    PUT  url=${ROST}/${UPDATE_PRODUCT}   headers=&{header}   json=&{body}

Deletar produto de id ${id} 
    &{headers}    Create Dictionary    Content-type=application/json

    ${DELETE_PRODUCT}=  Replace String    ${DELETE_PRODUCT}    id-produto-delete    ${id}
    ${Response}=   DELETE   url=${ROST}/${DELETE_PRODUCT}    headers=&{headers}
    RETURN    ${Response}
*** Test Cases ***

TC01 - Atualizar produto
    Arualizar produto   id=88  title=Xiomi  description=Celular original da xiomi  price=1987,99  brand=Samgsung


TC02 - Deleta produto
    ${response}   Deletar produto de id 1
    Should Be True    ${response.json()["isDeleted"]}