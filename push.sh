
#!/bin/sh

install_pandoc(){
    sudo apt-get update
    sudo apt-get install -y pandoc texlive-xetex
}

generate_pdf(){
    pandoc -f markdown --latex-engine=xelatex -V mainfont="DejaVu Sans Mono" -o docs/README.pdf README.md
}

setup_git() {
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "Travis CI"
}

commit_doc_files() {
    git checkout ${TRAVIS_BRANCH}
    git add .
    git commit --message "Travis build: $TRAVIS_BUILD_NUMBER [skip ci]"
}

upload_files() {
    git remote add origin-pages https://${DKEY}@github.com/s3rius/feedEm.git > /dev/null 2>&1
    git push --quiet --set-upstream origin-pages ${TRAVIS_BRANCH}
}

if [ "$TRAVIS_BRANCH" == "docs" ];then
    install_pandoc
    generate_pdf
    setup_git
    commit_doc_files
    upload_files
fi
