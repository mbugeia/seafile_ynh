import json

with open("/etc/ssowat/conf.json.persistent", "r") as jsonFile:
    data = json.load(jsonFile)
    if "ignore_urls" in data:
        data["ignore_urls"].append("/seafhttp")
    else:
        data["ignore_urls"] = ["/seafhttp"]
    data["ignore_urls"].append("/seafdav")

with open("/etc/ssowat/conf.json.persistent", "w") as jsonFile:
    jsonFile.write(json.dumps(data, indent=4, sort_keys=True))
