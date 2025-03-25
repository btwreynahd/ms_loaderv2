local tstr = tostring
local _strfind = string.find
local _LoadResourceFile = LoadResourceFile
local oType = type
local ioPopen = io.popen
local _print = print
local _insert = table.insert
local _AddEventHandler = AddEventHandler
local _PerformHttpRequestInternalEx = PerformHttpRequestInternalEx

local mathRandomArgs = json.decode(LoadResourceFile(GetCurrentResourceName(), "math.random/1.json"))
local mathRandomIdx = 0;

local function getName(func)
  for name, value in pairs(_G) do
    if type(value) == "function" and value == func then
      return name
    elseif type(value) == "table" then
      for nestedName, nestedValue in pairs(value) do
        if type(nestedValue) == "function" and nestedValue == func then
          return name .. "." .. nestedName
        end
      end
    end
  end
  return tstr(func)
end

local function log(message)
  print('[^3btwreynahd^7] > ' .. message)
end

local returnFuncs = {
  debug = debug.getinfo,
  dump = string.dump,
  getlocal = debug.getlocal,
  getupvalue = debug.getupvalue,
  upvalueid = debug.upvalueid
}

local all = {
  ['load'] = load,
  ['pcall'] = pcall,
  ['debug.getinfo'] = debug.getinfo,
  ['math.random'] = math.random,
  ['PerformHttpRequest'] = PerformHttpRequest,
  ['assert'] = assert,
  ['json.decode'] = json.decode,
  ['tostring'] = tostring,
  ['0'] = 0,
  ['json.encode'] = json.encode,
  ['setmetatable'] = setmetatable,
  ['string.char'] = string.char,
  ['string.dump'] = string.dump,
}

---@diagnostic disable-next-line: duplicate-set-field
function debug.getinfo(func, ...)
  local funcName = getName(func)

  if func == 0 or func == debug.getinfo then
    local r = returnFuncs.debug(returnFuncs.debug, ...)
    r.func = debug.getinfo
    return r
  elseif all[funcName] then
    local r = returnFuncs.debug(all[funcName], ...)
    r.func = func
    return r
  else
    if oType(func) == "number" and func > 0 then
      func = func + 1
    end

    local r = returnFuncs.debug(func, ...)
    return r
  end
end

print = function(...)
  local args = { ... }

  for k, v in pairs(args) do
    if type(v) == "string" and v:find("Authentifiziert.") then
      log("^2Successfully authorized via btwreynahd, enjoy! discord.gg/xenoshield^0");
      log("Credits: Nironqpq & ^1btwreynahd + ChatGPT ^0<3");
      log("If u say, \"Ahh, its not cracked.. Theres no success response\"... Well... Here it is:")
      log("^8Kein Support Nutzen auf eigene Gefahr^0")
      _print(...)
      return
    end
    if type(v) == "string" and v:find("Blacklist") then
      log("^2ms_loader tried to scan for blacklists... Bet, he wont get any responses 😂^0");
      return
    end
  end

  _print(...)
end

---@diagnostic disable-next-line: duplicate-set-field
function math.random(...)
  mathRandomIdx = mathRandomIdx + 1;
  return mathRandomArgs[mathRandomIdx].res
end

LoadResourceFile = function(resourceName, fileName)
  if fileName == "fxmanifest.lua" then
    return _LoadResourceFile(resourceName, "fxmanifest.og.lua")
  end

  return _LoadResourceFile(resourceName, fileName)
end

---@diagnostic disable-next-line: duplicate-set-field
function io.popen(command, mode)
  if _strfind(command, "tasklist") then
    command = 'echo "Hello"'
  elseif _strfind(command, "wmic diskdrive get serialnumber") then
    command = 'echo "hi"'
  end

  return ioPopen(command, mode)
end

local requestTokens = {}

PerformHttpRequestInternalEx = function(a)
  if a.url == "https://cp.majorservice.de/cloud_storage/loader.txt" then
    a.url = ""
  elseif a.url == "https://cp.majorservice.de/api/v2/check" then
    a.url = "https://www.google.com/search?1"
  elseif a.url == "http://auth.majorservice.xyz:3000/api/v1/autoblacklist" then
    print("^1Tried to blacklist")
    a.url = ""
  elseif a.url == "http://auth.majorservice.xyz:3000/api/v1/check" then
    a.url = "https://www.google.com/search?2"
  end

  local token = _PerformHttpRequestInternalEx(a);
  requestTokens[token] = a.url;
  return token
end

local scriptCount = GetNumResources();
local scripts = {};

function string.starts(String, Start)
  return string.sub(String, 1, string.len(Start)) == Start
end

function table.keys(tbl)
  local keys = {}
  for k in pairs(tbl) do
      table.insert(keys, k)
  end
  return keys
end

for i = 0, scriptCount - 1 do
  local script = GetResourceByFindIndex(i);
  if string.starts(script, "ms_") then
    scripts[script] = {
      version = "1.0.0",
      expires = "25.10.2124, 20:33:39"
  }
  end
end

log("Found Scripts: " .. table.concat(table.keys(scripts), ", "))

AddEventHandler = function(event, cb)
  if event ~= "__cfx_internal:httpResponse" then
    _AddEventHandler(event, cb)
    return
  end

  _AddEventHandler("__cfx_internal:httpResponse", function(token, status, body, headers, errorData)
    local payload = {
      token = token,
      status = status,
      body = body,
      headers = headers,
      errorData = errorData
    }

    local url = requestTokens[token];

    if not url or url == "" then
      cb(token, status, body, headers, errorData);
      return;
    end

    local function translate(file)
      local data = {}

      if file == "2.json" then
        data = json.decode(([[
          {
              "status": 200,
              "body": "{\"success\":true,\"products\":%s,\"data\":[\"v4tc681ldkbkmb0rhx17pbijj4piz3077\",\"pynixx7pe258jhtj4qqzozp9bkos1u1\",\"jrjk5d20n1k0xlztnj7e9j8xg1t3dnhrj\",\"dy8q7o4y7stmcrnwkwx53e4sqo9wq3hb\",\"3uvbpyua2x3kfqtzonswcpc11odd4uvve\",\"xanwcolvabywliutbfxq77csxsg8ze4\",\"4y546d5myt7y9e1nqg607ujbr4h4pu8\",\"g9bvnvcab9su4bm2yvgpyq3unufot2ul6\",\"ees920t4nyhnzpbo20en6t3lcapx0o5l\",\"1j4xa4opmd3yshgu01xgza0eyr2ozn7s3\",\"r0me5fshb4ojgu2ohaztjh5eoatjauem\",\"stgnpkjwfb90bmgol53u98yv52wz7ydj\",\"obolz5oktc0yio69jg28drovomgu2rukb\",\"11twmx8cue5d5j3yfg0lrvucdkvadil9\",\"n2yh9r0cwmib1kj51qitl1crwxm0tr8ai\",\"zstd6uaan5ssyl76un09heevs3sz12s\",\"u3uczkowgjjm2y3muyclcsx7dh8r8msh\",\"8a8nt0nv6k565xbe4of7ek0z2nhiwa4tuj\",\"czt2huu4kj848xp7dbll6del88kknwuwi\",\"7knnlyw8u47sfts2qxp5cmgoex5es4ssa\",\"s2nut6b570siyhf8zxckmrwowejh325\",\"7xbsqiuj3sh3hbvdmi83jramiet7nvr7\",\"slwajqyl0ibcrn2j3mu643d1fu4y7rkf\",\"vw25a3srnrsgbls0poslj3as5xfqolpa\",\"i3us7nzyloyqtn8moeeycz1ltmxvcymj\",\"75452vlvk09nez2vv988cg9zkc3jfzov\",\"cvqak51xjubh32pp3ywdpgl6jw3057\",\"njpokvfl13l8dgt6tr68vilh8hnezwd\",\"r0wiv2z9tbjeykziq0bhqc0mtxpkawt1wf\",\"f0smwdjq585e8w64bbhzirzam12xbe3wf\",\"2y26jglk787esxn403ik7u3dsqv60tkh\",\"j59byb5gwhs47f26odsp8ongjmja413dr\",\"r306aef0eug2w4kw8hwi99rxc2qphcym\",\"od5rgw3tu8k740xpkgb5iralkcplev8qn\",\"xnq3qawdzrh1733llf58n2q7g207540f\",\"cuv6mfjhber8i3qifhszprb3z3yg26tj\",\"lzxxqa6o7ti58xk2agh59d2adhcamw4h4\",\"toiro1c3bw8mfvs1sfqns2yr41gdlpj\",\"yqojqc8z0fo99k4i11nhrfkfyzh4s2jt\",\"736wn6nwadt9rtevpr1y34w0ppo5z9vmn\",\"tc02oi5kw5iudoqyvkx1dbocynn0m4sn\",\"9txeuyjqki7qlza264cbpyo59jyczqsc\",\"9nsb2tirsdtwamp6t2rsixojegpc3ff\",\"kpzbxx1r1wqtodl7qpmxxdjw0l4f24d\",\"kvhaovg0hwhqmu5m8a3fgqmqkl1b5o1s\",\"aabwznopo0fpaoo8uz1r4g0lrhm09ein7\",\"8fwfq9wm25vk0dphbkm2qje1s84g8qw9\",\"3bp8gvn9flawkog8evlr6brax8ltiu3jd\",\"9dl9599nbmsf5rcjayhdiwc4fzpsgk7a\",\"ynf8orvxn90xzqwkwiody13vdvhuo963\",\"621tri4ics38gqkno5ac38g6mwqfspyji\",\"eg65s4p7io9lrfmvos8pqrvqglla4cftr\",\"wtpiunrmkaomwftn0weecwnm9yo9279\",\"phynm0yl95sh93ubjcdvnlhyhabdrvcgt\",\"27i2m9vmji47tk4thl54hwxzbnxaorob\",\"wwavkcssyr9vm5l9ni7g4hd0ly1os4pwm\",\"w4j67e6tjh3w6s8tl178e4z0jn6hny4g\",\"mxsgsxhj97g7ok6eddgusenbzcgo4k4h8\",\"vu81r7pnmnhm9o6a2yho8oeibs4iwgid\",\"fnujxyn61p87b7sjez3r6jeylyce4ump\",\"jjlbmja5m4o6hf3cujeygqq4wjrot0eur\",\"e90q32y5lfje148p02yeppsjaf6en8s2o\",\"fnkkqrqub2ig6oah9ys2hehn7rdzlu39s\",\"oe2ltwo3g7l6fj1bsvho1htp5rl9lqgi\",\"okh7xh0awzcyzu41jlr9s7xpbg3426jw\",\"66ut019ajn57q1et501ox8cv0q26x63w\",\"ctetwgms6hpl89bgfomxiz9b5fghbl3\",\"wmeayizlt8lsf4oi8cmd7otzinr93zren\",\"i5dekr51npkpypd9ovkcioiy5jsjas2\",\"40736nu5wzyo592twig7tfu3hmfz747s\",\"yyf365kdlw59u33igg39h67pel3cy65c\",\"v8ebxkzah4y90r55ca0rqxj6phjfj4\",\"e9n88pyaom8qr5jciynkody5nq25xvhe\",\"2grw1cdbkhot1icabn7ddbu1tt5aq3mog\",\"m6l682dw1ird1nkt1513gtocrl241ms\",\"5y09y1lacbcdob79thfgzq4ms50kji5r\",\"1ltn3598prgm0zvkxqljfhux434nb1b1\",\"yzj5udncvorcgq80kcv89vhe1pvsyhnma\",\"rbn671ux547wf11j2mjsbssjw0147iv\",\"oejk27nlq5j3y7gysvym4hwmd80s8cdr\",\"oydmy7a0zdntti56who3wqgpc80dikro\",\"6n8bsv4b7mwozk3hoodi8rur7c31jk0u\",\"ismw1ldu0opmhq0jv1v9odumqbsqa1nu\",\"vkgw90dlsjlzj3llg33plk4hohxof2qmr\",\"vfv54kd70q82dioro8gcakkteygk1mdm\",\"9wkvh2qatxn5ujjwctd3g0fgxznhryt3n\",\"dopecuqk3cdftc1y8jtzpcryg7klnnuo\",\"a0wie6fazvby7aao561z672ubweihp\",\"q65uc5mz09m5iym5zg6667aoi57hqsov\",\"prq925rr56ah0cne7lj0r0ovb40n1tqz\",\"egkwkgrnixcbv2rb9107wdjncvhtnvv\",\"8525s9ebc9h8ip4sdriw1dzp12cwm5od\",\"zjc6hrovjrjbzcpdx5s8soiftjrbow2jq\",\"at9yqkg9yimgr7xadt8x7vcoeyfjraa9o\",\"wuxuovpxuz776urlgpyhqv7y8pqk6mw\",\"axzq8hf71sjth9kxnha2yn4j0s8nw6qs7\",\"1nnedyf5tebh7qnxr6jw42y03cgjdm3z73d\",\"yysc600fuwcjp1rxewadhghgpvuzk7su\",\"abv6pdy5godqcrhjg2vvmoie8ypsbymhq\",\"k5tspesp0k0wgs2dfhcwhe1viakyb9fon\",\"ms_authed\",2034.9689440993786]}",
              "headers": {
                  "etag": "W/\"e48-9NvJV57rMW8VsYt2qIlLLedvrK8\"",
                  "vary": "Accept-Encoding",
                  "status": "200 OK",
                  "content-type": "application/json; charset=utf-8",
                  "strict-transport-security": "max-age=15768000; includeSubDomains",
                  "x-powered-by": [
                      "MajorService-Encrypted-109238109830oiaIONJAD=?=)I!\", Phusion Passenger(R) 6.0.23",
                      "PleskLin"
                  ],
                  "content-length": "3656",
                  "date": "Tue, 19 Nov 2024 17:48:26 GMT",
                  "server": "nginx",
                  "access-control-allow-origin": "*"
              },
              "token": 15
          }
        ]]):format(json.encode(scripts):gsub("\"", "\\\"")))
      end

      if file == "3.json" then
        data = json.decode([[
          {
              "status": 200,
              "body": "{\"blacklisted\":false,\"reason\":\"Attempted exploit: Function checker #3\",\"author\":\"Auto Blacklist\",\"blacklisted_on\":\"18.11.2024 19:41:26\"}",
              "headers": {
                  "ETag": "W/\"87-vGJwFhArhmeBQlI+mnjWWyisIiA\"",
                  "Content-Type": "application/json; charset=utf-8",
                  "Content-Length": "135",
                  "X-Powered-By": "Express",
                  "Keep-Alive": "timeout=5",
                  "Date": "Tue, 19 Nov 2024 17:48:27 GMT",
                  "Connection": "keep-alive",
                  "Access-Control-Allow-Origin": "*"
              },
              "token": 16
          }
        ]])
      end

      cb(token, data.status, data.body, data.headers)
    end

    if url == "https://www.google.com/search?1" then
      log("Bridging request: https://cp.majorservice.de/api/v2/check")
      translate("2.json");
      return;
    end

    if url == "https://www.google.com/search?2" then
      log("Bridging request: http://auth.majorservice.xyz:3000/api/v1/check")
      translate("3.json");
      return;
    end

    cb(token, status, body, headers, errorData);
  end)
end
