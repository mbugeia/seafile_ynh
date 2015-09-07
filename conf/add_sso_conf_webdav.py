import json

with open("/etc/ssowat/conf.json.persistent", "r") as jsonFile:
    data = json.load(jsonFile)
    data["unprotected_urls"].append("/seafdav")

with open("/etc/ssowat/conf.json.persistent", "w") as jsonFile:
    jsonFile.write(json.dumps(data, indent=4, sort_keys=True))