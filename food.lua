 




local Date = gg.makeRequest("http://www.whatismyip.org/")
if (Date == "The user did not allow access to the Internet.") then
    return
elseif (Date == 'java.net.UnknownHostException: Unable to resolve host \"www.whatismyip.org\": No address associated with hostname') then
    gg.alert("Please connect to the network")
    return
else
    Date = Date['headers']['Date'][1]
    local monthMap = {
        Jan="01", Feb="02", Mar="03", Apr="04", May="05", Jun="06",
        Jul="07", Aug="08", Sep="09", Oct="10", Nov="11", Dec="12"
    }
    local serverDate = tonumber(
        string.sub(Date, 13, 16) ..
        monthMap[string.sub(Date, 9, 11)] ..
        string.sub(Date, 6, 7)
    )
    if serverDate >= tonumber("20260520") then
        gg.alert("Script Has Expired !")
        return
    end
end


v=gg.getTargetInfo()
is64=v.x64

function main()

gg.setVisible(false)

if is64 then 
fco1=24 
fco2=8 
fco3=16 
fcx1=32
else 
fco1=12 
fco2=4 
fco3=8 
fcx1=4 
end 

E=0
gg.toast("Please Wait..")
gg.clearResults()

gg.setRanges(gg.REGION_C_DATA | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_OTHER)

lengthf=#(f)

gg.searchNumber(":"..tostring(f),1)

if gg.getResultsCount()==0 then return end 

fbfc=gg.getResults(1)
gg.refineNumber(fbfc[1].value,1)
fbfc=gg.getResults(gg.getResultsCount())

nfbx={}
for i,v in ipairs(fbfc) do 
nfbx[i]={address=v.address+lengthf,flags=1}
end

gg.loadResults(nfbx)
gg.refineNumber(0,1)

if gg.getResultsCount()==0 then return end 

fbfc=gg.getResults(gg.getResultsCount())

nfbx={}
for i,v in ipairs(fbfc) do 
nfbx[i]={address=v.address-(lengthf+1),flags=1}
end

gg.loadResults(nfbx)
gg.refineNumber(0,1)

if gg.getResultsCount()==0 then return end 

fbfc=gg.getResults(gg.getResultsCount())

nfbx={}
for i,v in ipairs(fbfc) do 
nfbx[i]={address=v.address+1,flags=1}
end

gg.loadResults(nfbx)

gg.searchPointer(0)

if gg.getResultsCount()==0 then return end 

fpfc=gg.getResults(gg.getResultsCount())

gg.clearResults()

fofc={}
for i,v in ipairs(fpfc) do 
fofc[i]={address=v.address+fco1,flags=4}
end

gg.loadResults(fofc)

gg.refineNumber("4~5000",4)

if gg.getResultsCount()==0 then return end 

fofc=gg.getResults(gg.getResultsCount())

gg.clearResults()

fcfc={}
for i,v in ipairs(fofc) do 
fcfc[i]={address=v.address-fco2,flags=fcx1}
end

fcfc=gg.getValues(fcfc)

hcfc={}
for i,v in ipairs(fcfc) do    
hcfc[i]={flags=fcx1}

if is64 then 
HCFC=tostring(string.format("%X",tostring(fcfc[i].value)))   
if #(tostring(HCFC))>=12 then 
HCFC=tostring(string.sub(HCFC,3,-1)) 
end
HCFC=tonumber("0x"..HCFC)+fco3 
else 
HCFC=(fcfc[i].value)+fco3 
end

hcfc[i].address=HCFC
end 

hcfc=gg.getValues(hcfc)

for i,v in ipairs(hcfc) do

cnfc={}
for c=1,50 do 
cnfc[c]={address=v.value+c-1,flags=1}
end

cnfc=gg.getValues(cnfc)

csfc={}
for c=1,50 do

if cnfc[c].value~=0 and cnfc[c].value>32 and cnfc[c].value<127 then 
csfc[c]=string.char(cnfc[c].value)
else
csfc=table.concat(csfc)

if tostring(csfc)==tostring(x) then 
o=tonumber(fofc[i].value)
FCFC=fcfc[i].value
E=1
break
else
break 
end

end
end

if E==1 then break end 
end

if E==1 then 

gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)

gg.searchNumber(FCFC,fcx1)

if gg.getResultsCount()==0 then return end 

fcfc=gg.getResults(gg.getResultsCount())

FCFC={}
for i,v in ipairs(fcfc) do
FCFC[i]={address=v.address+o,flags=t}
end

gg.loadResults(FCFC)

gg.refineNumber(0, gg.TYPE_BYTE)

if gg.getResultsCount()==0 then
gg.toast("Value 0 not found")
return
end

r=gg.getResults(gg.getResultsCount())

for i,v in ipairs(r) do
r[i].value=1
r[i].flags=gg.TYPE_BYTE
end

gg.setValues(r)

gg.toast("Hack ON")

end

libstart=gg.getRangesList('libil2cpp.so')[2].start
--_OnClickDebugBtn 0x39EC694
--_OnClickGemAddBtn 0x39EC854
patch={}
patch[1]={address=libstart+0x33FDF0C,flags=4,value='~A8 B [PC,#-0x1C0]'}
patch[2]={address=libstart+4+0x33FDF0C,flags=4,value='~A8 RET'}

gg.setValues(patch)


gg.clearResults()

gg.toast("Script Success")


gg.setVisible(true)

end

x='GameSwitchManager'
f='isDebugMode'
t=1

main()
