echo '$TRAVIS_PULL_REQUEST $TRAVIS_BRANCH'
echo $TRAVIS_PULL_REQUEST $TRAVIS_BRANCH

if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
    echo "This is a pull request. No deployment will be done."; exit 0
fi

if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    echo "No deployment on BRANCH='$TRAVIS_BRANCH'"; exit 0
fi

# Create the docs and push them to S3
# -----------------------------------
echo "About to install numpydoc, s3cmd"
pip install numpydoc s3cmd
conda list -e
mkdir -p docs/_build
echo "About to build docs"
sphinx-build -b html docs docs/_build
echo "About to push docs to s3"
python devtools/travis-ci/push-docs-to-s3.py
