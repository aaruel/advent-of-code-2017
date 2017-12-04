const spiral = (n) => {
    const k = Math.ceil((Math.sqrt(n) - 1) / 2);
    let t = 2 * k + 1;
    let m = Math.pow(t, 2);
    t -= 1;
    if (n >= m - t) return [k - (m - n), -k];
    m -= t;
    if (n >= m - t) return [-k, -k + (m - n)];
    m -= t;
    if (n >= m - t) return [-k + (m - n), k];
    return [k, k - (m - n - t)];
};

class SpiralNode {
    constructor(coords, index, sum) {
        this.coords = coords;
        this.index = index;
        this.sum = sum || 0;
    }
    
    setSum(sum) {
        this.sum = sum;
    }
    
    getSum() {
        return this.sum;
    }
}

const buildSpiral = (limitSum) => {
    let spiralNodes = {};
    let testSum = 0; 
    for (let i = 1; testSum < limitSum; ++i) {
        const coords = spiral(i);
        const x = coords[0]; 
        const y = coords[1];
        const key = JSON.stringify(coords);
        if (i === 1) {
            spiralNodes[key] = new SpiralNode(coords, i, 1);
        }
        else {
            spiralNodes[key] = new SpiralNode(coords, i);
            const checkCoords = (coords) => {
                const k = JSON.stringify(coords);
                const n = spiralNodes[k];
                if (n) {
                    return n.getSum();
                }
                else {
                    return 0;
                }
            };
            let sum = 0;
            // left
            sum += checkCoords([x-1,y-1]);
            sum += checkCoords([x-1,y]);
            sum += checkCoords([x-1,y+1]);
            // middle
            sum += checkCoords([x,y-1]);
            sum += checkCoords([x,y+1]);
            // right
            sum += checkCoords([x+1,y-1]);
            sum += checkCoords([x+1,y]);
            sum += checkCoords([x+1,y+1]);
            
            spiralNodes[key].setSum(sum);
            testSum = sum;
        }
        console.log(spiralNodes[key]);
    }
};

buildSpiral(parseInt(prompt()));