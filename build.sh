#!/usr/bin/env bash

echo "Cleaning up..."
rm -rf FLEX/ src/

echo "Copying sources..."
mkdir src/
git clone --depth=1 https://github.com/FLEXTool/FLEX
find FLEX/Classes -type f \( -name "*.h" -o -name "*.m" -o -name "*.mm" -o -name "*.c" \) -exec cp {} src/ \;

FILE="src/FLEXSwiftInternal.mm"

# Replace "std::atomic<mask_t> _maybeMask;" with "mask_t _maybeMask;" on line 59
sed -i '' '59s/std::atomic<mask_t> _maybeMask;/mask_t _maybeMask;/' "$FILE"
# Replace "std::atomic<preopt_cache_t *> _originalPreoptCache;" with "preopt_cache_t * _originalPreoptCache;" on line 65
sed -i '' '65s/std::atomic<preopt_cache_t \*> _originalPreoptCache;/preopt_cache_t \* _originalPreoptCache;/' "$FILE"

make package