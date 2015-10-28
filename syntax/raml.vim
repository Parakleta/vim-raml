" Vim syntax file
" Language: RAML
" Maintainer: Duane Leslie

syn match ramlVersion "^#%RAML\s\+\d.\d\ze\_s"

syn keyword field baseUri mediaType title version schemas securedBy

syn region rootNamedParameterGroup matchgroup=field fold skip="^\s*$"
    \   start="^\z(\s*\)baseUriParameters:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,voidParameterGroup
syn region namedParameterGroup matchgroup=field fold contained skip="^\s*$"
    \   start="^\z(\s*\)uriParameters:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,voidParameterGroup
syn region voidParameterGroup matchgroup=parameter fold contained skip="^\s*$"
    \   start="^\z(\s*\)[^:]\+:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,parameterField
syn keyword parameterField contained
    \   description displayName example default enum maximum maxLength minimum
    \   minLength pattern required type

" XXX This should require a YAML Collection
syn region protocolGroup matchgroup=field fold skip="^\s*$"
    \   start="^\z(\s*\)protocols:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,protocol
syn keyword protocol contained HTTP HTTPS

" XXX This should require a YAML Collection
syn region rootDocumentationGroup matchgroup=field fold skip="^\s*$"
    \   start="^\z(\s*\)documentation:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,rootDocumentation
syn keyword rootDocumentation contained content title

" XXX NYI (void level as per parameterGroup), then missing fields
syn region securitySchemesGroup matchgroup=field fold skip="^\s*$"
    \   start="^\z(\s*\)securitySchemes:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow

syn cluster resourceCommonGroup
    \   contains=rootNamedParameterGroup,namedParameterGroup,resourceBasic,methodGroup
syn cluster methodCommonGroup
    \   contains=methodField,methodFieldGroup,protocolGroup,rootNamedParameterGroup

syn region resourceTypeGroup matchgroup=field fold skip="^\s*$"
    \   start="^\z(\s*\)resourceTypes:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,voidResourceTypeGroup
syn region voidResourceTypeGroup matchgroup=parameter fold contained skip="^\s*$"
    \   start="^\z(\s*\)[^:]\+\ze:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,resourceType,@resourceCommonGroup
syn keyword resourceType contained usage

syn region traitGroup matchgroup=field fold skip="^\s*$"
    \   start="^\z(\s*\)traits:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,voidTraitGroup
syn region voidTraitGroup matchgroup=parameter fold contained skip="^\s*$"
    \   start="^\z(\s*\)[^:]\+\ze:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,traitField,@methodCommonGroup
syn keyword traitField contained displayName usage

syn region resourceGroup matchgroup=resource fold skip="^\s*$"
    \   start="^\z(\s*\)/[^:[:space:]]*:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,resourceGroup,@resourceCommonGroup

syn keyword resourceBasic contained description displayName securedBy type is

syn region methodGroup matchgroup=method fold contained skip="^\s*$"
    \   start="^\z(\s*\)\(options\|get\|head\|post\|put\|delete\|trace\|connect\|patch\):"
    \   end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,@methodCommonGroup,methodExtra
syn keyword methodExtra contained is

syn keyword methodField contained description securedBy
syn region methodFieldGroup matchgroup=methodField fold contained skip="^\s*$"
    \   start="^\z(\s*\)\(headers\|queryParameters\):" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,voidParameterGroup

syn region methodFieldGroup matchgroup=methodField fold contained skip="^\s*$"
    \   start="^\z(\s*\)body:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,methodBody,methodBodyGroup
syn match methodBody contained "application\/\(json\|xml\)"
syn region methodBodyGroup matchgroup=methodBody fold contained skip="^\s*$"
    \   start="^\z(\s*\)application\/x-www-form-urlencoded:"
    \   start="^\z(\s*\)multipart\/form-data:"
    \   end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,voidParameterGroup

syn region methodFieldGroup matchgroup=methodField fold contained skip="^\s*$"
    \   start="^\z(\s*\)responses:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,responseGroup
syn region responseGroup matchgroup=method fold contained skip="^\s*$"
    \   start="^\z(\s*\)\d\{3\}:" end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,responseField,responseFieldGroup
syn keyword responseField contained description
syn region responseFieldGroup matchgroup=responseField fold contained skip="^\s*$"
    \   start="^\z(\s*\)application\/\(json\|xml\):"
    \   start="^\z(\s*\)application\/x-www-form-urlencoded:"
    \   start="^\z(\s*\)multipart\/form-data:"
    \   end="^\(\z1\s\)\@!"
    \   contains=@yamlFlow,responseMimeField
syn keyword responseMimeField contained schema example

hi link ramlVersion Define
hi link field Label
hi link parameter Identifier
hi link protocol Constant
hi link methodBody Constant
hi link method Function
hi link resource Underlined

hi link parameterField field
hi link rootDocumentation field
hi link resourceType field
hi link traitField field
hi link resourceBasic field
hi link methodField field
hi link methodExtra field
hi link responseField field
hi link responseMimeField field


