<?php

declare(strict_types=1);

namespace kuaukutsu\ec\spx;

use Throwable;
use Symfony\Component\Console\Application;
use Symfony\Component\Console\Command\Command;
use kuaukutsu\ec\spx\presentation\StartCommand;

require_once dirname(__DIR__) . '/vendor/autoload.php';

$console = new Application();
$console->addCommands(
    [
        new StartCommand(),
    ]
);

spx_profiler_start();

try {
    exit($console->run());
} catch (Throwable $e) {
    echo $e->getMessage() . PHP_EOL;
    exit(Command::FAILURE);
} finally {
    spx_profiler_stop();
}
