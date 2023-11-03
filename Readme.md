# pandoc-filter-comtext

Фильтры Comtext для [Pandoc](https://pandoc.org/).

Использование:

```
pandoc -o book.txt --lua-filter ./remove-page-numbers.lua book.md
```