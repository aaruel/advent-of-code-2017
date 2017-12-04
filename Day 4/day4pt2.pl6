my $sum = 0;
for $*IN.lines() -> $line {
    my @sorted = $line.split(" ");
    my @uniq = @sorted.map({$_.comb.sort.join}).unique;
    if @sorted.elems == @uniq.elems {
        $sum++;
    }
}
say $sum