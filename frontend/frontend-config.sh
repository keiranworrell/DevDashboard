#!/bin/bash

orgs=""
orgList=`yq '.devDash | keys[]' /mnt/config.yaml`
actionLinks=""
actionsArr="["
for org in ${orgList}; do
    repoLinks=""
    repoList=`yq ".devDash.${org} | keys[]" /mnt/config.yaml`
    for repo in ${repoList}; do
        repoLinks="${repoLinks}<li><a href='https://github.com/${org}/${repo}'>${org}/${repo}</a></li>\n"
        actionList=`yq ".devDash.${org}.${repo}.actions | keys[]" /mnt/config.yaml`
        echo "actionList:"
        echo ${actionList}
        if [[ ${actionList} != "null" && ${actionList} != "" && ${actionList} != "0" ]]; then
            actionLinks="${actionLinks}<h2>${org}/${repo} - Actions</h2><ul>\n"
            for action in ${actionList}; do
                action=`echo ${action} | cut -f1 -d'.'`
                actionLinks="${actionLinks}<li><div id=\"gh-status-${org}-${repo}-${action}\">Loading...</div></li>\n"
                
                actionsArr="${actionsArr}\"${org}-${repo}-${action}\", "
            done
            actionLinks="${actionLinks}</ul>\n"
        fi
    done
done

echo "actionsArr:"
echo "${actionsArr::-1}]"
sed -i "s|actions=[]|${actionsArr::-1}]|" /usr/share/nginx/html/script.js
echo "repoLinks:"
echo ${repoLinks}
sed -i "s|<placeholder>|${repoLinks}|" /usr/share/nginx/html/index.html

echo "actionLinks:"
echo ${actionLinks}
sed -i "s|<actionsPlaceholder>|${actionLinks}|" /usr/share/nginx/html/actions.html

sed -i "s|convenient|useful|" /usr/share/nginx/html/index.html