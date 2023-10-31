make_tag() {
    if [ $# -lt 2 ]; then
        echo "<p>function needs at least 2 arguments</p>"
        return 1
    fi
    
    tag_name="$1"
    shift 1
    content="$@"
    
    echo "<$tag_name>$content</$tag_name>"
}

make_tag_id() {
    if [ $# -ne 3 ]; then
        echo "<p>function needs 3 arguments</p>"
        return 1
    fi
    echo "<$1 id=\"$3\">$2</$1>"
}

let() {
    if [ $# -ne 2 ]; then
        echo "<p>function needs 2 arguments</p>"
        return 1
    fi
    echo "let $1 = $2;"
}

increment() {
    if [ $# -ne 1 ]; then
        echo "<p>function needs 1 argument</p>"
        return 1
    fi
    echo "$1++;"
}

change_inner_by_id() {
    if [ $# -ne 2 ]; then
        echo "<p>function needs 2 arguments</p>"
        return 1
    fi
    echo "document.getElementById('$1').innerHTML = \`$2\`;"
}

add_event_listener_by_id() {
    if [ $# -ne 3 ]; then
        echo "<p>function needs 3 arguments</p>"
        return 1
    fi
    echo "document.getElementById('$1').addEventListener('$2', $3);"
}

make_function() {
    if [ $# -ne 2 ]; then
        echo "<p>function needs 2 arguments</p>"
        return 1
    fi
    echo "function $1() { $2 }"
}


make_tag "center" "$(\
    make_tag "h1" "Clicks counter"
)" "$(\
    make_tag_id "button" "clicks: 0" "counter"
)"

make_tag "script" "$(\
    let "counter" "0"
)" "$(\
    make_function "increment_counter" "$(\
        increment "counter"
        change_inner_by_id "counter" "clicks: \${counter}"
    )"
    add_event_listener_by_id "counter" "click" "increment_counter"
)"
