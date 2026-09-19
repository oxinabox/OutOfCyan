to_print = [
("saltwarter", 53000),
("our", 25000),
#==
("I", 1001),
("shout", 2000),
("we", 3000),
("everything", 4001),
("shines", 5000),
("on", 6000),
("world", 7000),
("postcard", 9000),
("a", 10000),
("and", 11000),
("ship", 12000),
("I'm", 13000),
("forever", 14000),
("but", 15000),
("I'll", 16000),
("more", 17000),
("wait", 18000),
("tell", 19000),
("free", 20000),
("be", 21000),
("souls", 22000),
("think", 23000),
("all", 24000),

("cover", 26000),
("all", 27000),
("can", 28000),
("sky", 29000),
("from", 30000),
("—", 31000),
("a", 32000),
("we're", 33000),
("for", 34000),
("belong", 35000),
("all", 36000),
("storm", 37000),
("it", 38000),
("keep", 39000),
("through", 41000),
("don't", 42000),
("I'd", 43000),
("road", 44000),
("smile", 45000),
("a", 46000),
("parents", 47000),
("and", 48000),
("history", 49000),
("make", 50000),
("scars", 51000),
("eyes", 52000),

("green", 54000),
]
==#

("transexual", 3000),
("faggot", 3100),
("people", 3200),
("need", 3300),
("are", 3400),
("dream", 3500),
("they", 3600),
("who", 3700),
("never", 3800),
("autistic", 3900),
("joy", 3950),
]

pending = []
for (word, seed) in to_print
    filename = "out/$(word)_$seed.stl"
    command = `openscad pebble.scad -D word=\"$word\" -D seed=$seed -o $filename`
    @info "generating" word seed command
    push!(pending, (run(command, wait=false), filename))
end
@info "🚀🚀🚀All launched! 🚀🚀🚀"
for (proc, filename) in pending
    @info "waiting for" filename
    success(proc)
end
@info "done"