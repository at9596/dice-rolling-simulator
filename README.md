# Dice Rolling Simulator

A simple Ruby program to simulate rolling sets of dice with varying numbers of sides. Includes unit tests using RSpec and an optional command-line interface (CLI).

## Features

*   Simulates rolling dice collections (e.g., 2d6, 1d20, 3d8 + 1d4).
*   Provides results including:
    *   Description of dice rolled (e.g., "2d6 + 1d20").
    *   Individual values from each die.
    *   Total sum of all dice values.
*   Core logic is unit-tested with RSpec.
*   Includes an optional interactive CLI (`main.rb`).

## Requirements

*   Ruby (developed with 3.x, should work on recent versions)
*   Bundler

## Setup

1.  Clone the repository:
    ```bash
    git clone <repository-url>
    cd dice-rolling-simulator
    ```
2.  Install dependencies:
    ```bash
    bundle install
    ```

## Usage

### Running Tests

To run the RSpec unit tests:

```bash
bundle exec rspec