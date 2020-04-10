#!/bin/bash
echo "Buscar '$1'"
find . -name "*.xaml" -exec grep -iH "$1" {} \;
