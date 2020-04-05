local function PickComments(str)
    local tokens={}
    local index=str:find('/')
    local status=false
    local last_status_change=1
    while index do
        currsym=str:sub(index+1,index+1)
        if status then
            if str:sub(index-1,index-1)=='*' then
                status=false
                tokens[#tokens+1]={"coment",str:sub(last_status_change,index)}
                last_status_change=index+1
                if index>=#str then
                  return tokens
                end
            end
        else
            if str:sub(index+1,index+1)=='*' then
                status=true
                tokens[#tokens+1]={"code",str:sub(last_status_change,index-1)}
                last_status_change=index-1
            end
        end
        index=str:find('/',index+1)
    end
    return tokens[#tokens+1]=str:sub(last_status_change,#str)
end

local function PickStrings(tokens,str)
    local index=str:find('[\'"]')
    local status
    local last_status_change=1
    while index do
        currsym=str:sub(index,index)
        if currsym==status then
            if str:sub(index-1,index-1)~='\\' then
                status=nil
                tokens[#tokens+1]={'string',str:sub(last_status_change,index)}
                last_status_change=index+1
                if index>=#str then
                    return tokens
                end
            end
        else
            if currsym=='"' or currsym=="'" then
                status=currsym
                tokens[#tokens+1]={'code',str:sub(last_status_change,index-1)}
                last_status_change=index
            end
        end
        index=str:find('[\'"]',index+1)
    end
    tokens[#tokens+1]={'code',str:sub(last_status_change,#str)}
    return tokens
end

--return function(str)
function Minify(Str)
    local Tokens1=PickComments(Str)
    local Tokens2={}
    for k,i in pairs(Tokens1) do
        Tokens2[Tokens2+1]=PickStrings(Tokens2)
    end
    local function RepAll(old,new)
        for k,i in pairs(Tokens2) do
            if i[1]=='code' then
                Tokens2[k][2]=i[2]:gsub(old,new)
            end
        end
    end
    local function CompactAll(sym)
        for k,i in pairs(Tokens) do
            if i[1]=='code' then
                local Str=i[2]
                while Str:find(sym..sym) do
                    Str=Str:gsub(sym..sym,sym)
                end
                Tokens2[k][2]=Str
            end
        end
    end
    for k,i in pairs{'\f','\n','\t','\v'} do
        RepAll(i,' ')
    end
    RepAll('\n',' ')
    CompactAll(';')
    CompactAll(' ')
    local specialsyms={'%[','%]','"',"'",';','}','{','%(','%)',':','<','>',',','#','.','@'}
    for _,i in pairs(specialsyms) do
        RepAll(i..' ',i)
        RepAll(' '..i,i)
    end
    RepAll(';}','}')
    
    local Out=''
    for _,i in pairs(Tokens2) do
        Out=Out..i[2]
    end
    return Out
end
print(Minify([[
*{
    display:  block;  /*
    margin: 3;  */
    font-size:67px;
}
 . a : h ( i > b  < m )          {
    color:red;;;;q;;
}
 # a , ]]..'\tb \t\v '..[[        {
    color:red;;;;q;;
}
]]))
