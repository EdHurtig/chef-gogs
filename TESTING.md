# Testing

```bash
cookstyle && foodcritic -f any -X spec . && rspec --color --format progress && kitchen test
```

## Style

Style is defined in `.rubocop.yml`

## Rspec

Execute with

```
rspec --color --format progress
```

## Test Kitchen

Run the tests with `kitchen test`, ensuring they all pass.

