#!/bin/bash

orgs=""
orgList=`yq '.devDash | keys[]' /mnt/config.yaml`
echo "orgList:"
echo ${orgList}
for org in ${orgList}; do
    repoLinks=""
    repoList=`yq ".devDash.${org} | keys[]" /mnt/config.yaml`
    echo "repoList:"
    echo ${repoList}
    for repo in ${repoList}; do
        repoLinks="${repoLinks}<li><a href='https://github.com/${org}/${repo}'>${org}/${repo}</a></li>\n"
        actionLinks=""
        actionList=`yq ".devDash.${org}.${repo}.actions | keys[]" /mnt/config.yaml`
        echo "actionList:"
        echo ${actionList}
        if [[ ${actionList} != "null" && ${actionList} != "" && ${actionList} != "0" ]]; then
            actionLinks="${actionLinks}<h2>${org}/${repo} - Actions</h2><ul>\n"
            for action in ${actionList}; do
                actionLinks="${actionLinks}<li><a href='https://github.com/${org}/${repo}/actions/workflows/${action}'>`yq \".devDash.${org}.${repo}.actions.${action}\" /mnt/config.yaml`</a></li>\n"
            done
            actionLinks="${actionLinks}</ul>\n"
        fi
    done
done
echo "repoLinks:"
echo ${repoLinks}
sed -i "s|<placeholder>|${repoLinks}|" /usr/share/nginx/html/index.html

echo "actionLinks:"
echo ${actionLinks}
sed -i "s|<actionsPlaceholder>|${actionLinks}|" /usr/share/nginx/html/actions.html

sed -i "s|convenient|useful|" /usr/share/nginx/html/index.html