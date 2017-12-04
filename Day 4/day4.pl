my $sum = 0;
foreach $line (<>) {
    my @list = split ' ', $line;
    my %seen;
    my @uniq = grep {!$seen{$_}++} @list;
    my $listlength = scalar @list;
    my $uniqlength = scalar @uniq;
    if ($uniqlength == $listlength) {
        $sum++;
    }
}
print $sum;