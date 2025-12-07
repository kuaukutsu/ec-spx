# Example Code: SPX, which stands for Simple Profiling eXtension, is just another profiling extension for PHP.

https://github.com/NoiseByNorthwest/php-spx

```shell
make up
```

## HTTP app

http://localhost/?SPX_REPORT=full&SPX_ENABLED=1&SPX_AUTO_START=1

## CLI app

```shell
make app
```

```shell
SPX_ENABLED=1 SPX_REPORT=full SPX_AUTO_START=0 php cli.php spx:start
```

## Web UI

http://localhost/?SPX_UI_URI=/

