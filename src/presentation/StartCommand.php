<?php

declare(strict_types=1);

namespace kuaukutsu\ec\spx\presentation;

use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

#[AsCommand(
    name: 'spx:start',
    description: 'spx start',
)]
final class StartCommand extends Command
{
    public function __invoke(InputInterface $input, OutputInterface $output): int
    {
        $output->writeln('<info>spx start</info>');
        return Command::SUCCESS;
    }
}
