let td_executable = (
    which --all td
    | where {|entry| $entry.path != "source" and ($entry.path | path exists) }
    | first
    | get path
)

let td_cache_revision = (
    open --raw $td_executable
    | hash sha256
)

$env.__TD_COMPLETION_CACHE = (
    $nu.cache-dir
    | path join "td-completions" $td_cache_revision
)
mkdir $env.__TD_COMPLETION_CACHE

def "td-completion-cache fetch" [line: string] {
    let cache_file = (
        $env.__TD_COMPLETION_CACHE
        | path join $"($line | hash sha256).nuon"
    )

    if ($cache_file | path exists) {
        open $cache_file
    } else {
        let fetched = with-env {
            COMP_LINE: $line
            COMP_POINT: "999999", 
            COMP_CWORD: "1", 
            SHELL: "fish"
        } {
            ^td completion-server
            | from tsv --flexible --noheaders --no-infer
            | rename value description
        }

        $fetched | to nuon | save --force $cache_file
        $fetched
    }
}

def "nu-complete td" [spans: list<string>] {
    let current = $spans | last

    # Normalize the current prefix so "--p", "--pr", etc. share one cache.
    let query_current = if ($current | str starts-with "-") {
        if ($current | str contains "=") {
            $current | str replace --regex '=.*$' '='
        } else {
            "--"
        }
    } else {
        ""
    }

    let query_spans = $spans | drop 1 | append $query_current
    let line = $query_spans | str join " "
    let completions = (td-completion-cache fetch $line)

    $completions
    | where {|item| $item.value starts-with $current }
}

def "td-completion-cache warm" [] {
    mut pending = [
        ["td"]
    ]
    mut command_count = 0

    while ($pending | is-not-empty) {
        let results = (
            $pending
            | par-each --threads 8 {|command_path|
                let command = $command_path | str join " "
                let normal = (td-completion-cache fetch $"($command) ")

                # Cache the flag menu even when this command has subcommands.
                td-completion-cache fetch $"($command) --" | ignore

                let children = (
                    $normal
                    | where {|item| not ($item.value | str starts-with "-") }
                    | get value
                )

                {path: $command_path, children: $children}
            }
        )

        $command_count += ($results | length)
        $pending = (
            $results
            | each {|result|
                $result.children
                | each {|child| $result.path | append $child }
            }
            | flatten
        )
    }

    print $"Warmed Todoist completions for ($command_count) command contexts."
}

@complete "nu-complete td"
extern td []
