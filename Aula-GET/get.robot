*** Settings ***
Library    RequestsLibrary
Library    String
*** Variables ***
${ROST}    https://dummyjson.com

###Rotas
${GET_ALL_PRODUCTS}   products  
${GET_SINGLE_PRODUCT}   products/id-produto
${SEARCH_PRODUCT}   products/search?q=tipo-produto
${SORT_PRODUCT}   products?sortBy=type&order=asc

*** Keywords ***
Pegar todos os produtos 
    &{header}    Create Dictionary    Content-type=application/json

    GET  url=${ROST}/${GET_ALL_PRODUCTS}    headers=&{header}    expected_status=200

Pegar um unico produto de id ${id}
    &{header}    Create Dictionary    Content-type=application/json
    ${GET_SINGLE_PRODUCT} =  Replace String  ${GET_SINGLE_PRODUCT}  id-produto  ${id}


    ${response}=   GET  url=${ROST}/${GET_SINGLE_PRODUCT}    headers=&{header}

    RETURN   ${response}    

Buscar produto pelo tipo ${tipo}
    &{header}    Create Dictionary    Content-type=application/json
    ${SEARCH_PRODUCT}=  Replace String   ${SEARCH_PRODUCT}  tipo-produto  ${tipo}
    GET  url=${ROST}/${SEARCH_PRODUCT}    headers=&{header}

Ordenar por tipo ${type} crescente 
    &{header}    Create Dictionary    Content-type=application/json
    ${SORT_PRODUCT}=  Replace String   ${SORT_PRODUCT}  type   ${type} 

    GET  url=${ROST}/${SORT_PRODUCT}    headers=&{header}
Ordenar por tipo ${type} decrescente 
    &{header}    Create Dictionary    Content-type=application/json
    ${SORT_PRODUCT}=  Replace String   ${SORT_PRODUCT}  type   ${type}
    ${SORT_PRODUCT}=  Replace String   ${SORT_PRODUCT}  asc   desc
        

    GET  url=${ROST}/${SORT_PRODUCT}    headers=&{header}

*** Test Cases ***

TC01 - Realizar busca de todos os produtos 
    Pegar todos os produtos


TC02 - Realizar busca de um unico produto 
    ${Response_return}   Pegar um unico produto de id 1
    Should Be Equal As Strings    ${Response_return.status_code}    200
    Should Be Equal As Strings    ${Response_return.json()["title"]}    Essence Mascara Lash Princess
    Should Be Equal As Strings    ${Response_return.json()["price"]}    9.99  
    
    Log    ${Response_return.json()}
    Log    ${Response_return.json()["title"]}


TC03 - Buscar produtos
    Buscar produto pelo tipo phone

TC04 - Ordenar produto 
    Ordenar por tipo id crescente 
    Ordenar por tipo id decrescente 

