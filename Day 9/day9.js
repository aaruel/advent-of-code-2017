const getScore = (input) => {
    var level = 1;
    return input
        .replace(/(!.)/g, "")
        .replace(/(<>|<.+?>)/g, "")
        .replace(/(,)/g, "")
        .split("")
        .reduce((acc, char) => {
            if (char === "{") {
                acc += level;
                level++;
                return acc;
            }
            else if (char === "}") {
                level--;
                return acc;
            }
        }, 0);
};

const getGarbage = (input) => {
    const initial = input
        .replace(/(!.)/g, "")
        .match(/(<>|<.+?>)/g);
    if (initial !== null) {
        return initial
            .reduce((acc, str) => {
                return acc + (str.length - 2);
            }, 0);
    }
    else {
        return 0;
    }
};