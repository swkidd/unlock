# Runs all the tests!

# Note: explicit || exit 1 is important (but brittle) https://github.com/unlock-protocol/unlock/issues/194

# Solidity tests
cd /home/unlock/smart-contracts
# missing npm module from the truffle/ci image
npm install

truffle test --network test || exit 1
npm run lint || exit 1

# React tests && linting
cd /home/unlock/unlock-app
npm install
CI=1 npm test || exit 1
npm run lint || exit 1
# Check that the styling guide is respected
npm run reformat
CHANGED=$(git diff-index --name-only HEAD --)
if [ -n "$CHANGED" ]; then
  echo "Format discrepancies. Please run \`npm run reformat\` before your commit."
  echo "Files with wrong format:"
  echo $CHANGED
  exit 1
fi

