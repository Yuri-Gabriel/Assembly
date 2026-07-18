# Assembly

Aprendendo assembly. Porque não?

## Comandos para compilar

Compilar de fato

``` bash
    nasm 0f elf64 main.asm -o main.o
```

Linkar

``` bash
    ld main.o -o main
```

Função para compilar

``` bash
function comp_asm() {
       mkdir -p linkers executables
       nasm -f elf64 "$1.asm" -o linkers/"$1.o" && ld linkers/"$1.o" -o executables/"$1"
}

```

Rodar

``` bash
    ./main
```