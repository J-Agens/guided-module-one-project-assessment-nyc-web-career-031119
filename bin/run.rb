require_relative '../config/environment'
cli = CommandLineInterface.new
puts "
                                  ...,
                                  ...
                                 ...,
                                  ..,
                                  *..
                                   ,...
                                    ,....
                                      ,...,
                                        ....
                                          ...
                                          ....
                     ................,,,,...,        ,...     , ,
               ............ ...........  ... ,..................      ,.
             ...................         ...             ,............
            ..........,                                          ,.........
             ........                                                ......
   .......... ,....................               .....       ...........
 ..................    ,............................................, ..
....       ,.......               ,,,,...............,,,,,,,         ..
...           ,....                                                  ..
...            ,...                                                 ...
....            ....            The Job App                         ..
 ,....          ....                                               ...
    .......      ....                                             ...,
          .....   ...                                            ....
               ,.. ...                                          ....
                 ,. ....                                       ..........
                  .,,....                                    ....................
       ,  .,   ,       ....                           ..........       ,..............
      .  .                 ,... ,                ............,                 ,.........
  .. ..                           ,.. .     ............                          .......
   .  .                              ,.................                         .........
     ,......                                                              ..............
          .................                             ............................,
                ,..............................................................
                        ,.............................................,,
"
sleep(2)
puts `clear`
cli.run
