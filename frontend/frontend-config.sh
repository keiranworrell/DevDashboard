#!/bin/bash

orgs=""
orgList=`yq '.devDash | keys[]' /tmp/config.yaml`
echo "orgList:"
echo ${orgList}
for org in ${orgList}; do
    repoLinks=""
    repoList=`yq ".devDash.${org} | keys[]" /tmp/config.yaml`
    echo "repoList:"
    echo ${repoList}
    for repo in ${repoList}; do
        repoLinks="${repoLinks}<li><a href='https://github.com/${org}/${repo}'>${org}/${repo}</a></li>\n"
        actionLinks=""
        actionList=`yq ".devDash.${org}.${repo}.actions | keys[]" /tmp/config.yaml`
        echo "actionList:"
        echo ${actionList}
        if [[ ${actionList} != "null" && ${actionList} != "" ]]; then
            actionLinks="${actionLinks}<h2>${org}/${repo} - Actions</h2><ul>\n"
            for action in ${actionList}; do
                actionLinks="${actionLinks}<li><a href='https://github.com/${org}/${repo}/actions/workflows/${action}'>`yq \".devDash.${org}.${repo}.actions.${action}\" /tmp/config.yaml`</a></li>\n"
            done
            actionLinks="${actionLinks}</ul>\n"
        fi
    done
done
echo "repoLinks:"
echo ${repoLinks}
sed -i "s|<placeholder>|${repoLinks}|" /usr/share/nginx/html/index.html



sed -i "s|convenient|useful|" /usr/share/nginx/html/index.html