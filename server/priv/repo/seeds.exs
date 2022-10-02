alias Server.S3
alias Server.Pets.Dog
alias Server.Repo

breed_to_description_map = %{
  "affenpinscher" =>
    "Loyal, curious, and famously amusing, this almost-human toy dog is fearless out of all proportion to his size. As with all great comedians, it's the Affenpinscher's apparent seriousness of purpose that makes his antics all the more amusing.

  The Affen's apish look has been described many ways. They've been called 'monkey dogs' and 'ape terriers.' The French say diablotin moustachu ('mustached little devil'), and Star Wars fans argue whether they look more like Wookies or Ewoks. Standing less than a foot tall, these sturdy terrier-like dogs approach life with great confidence. 'This isn't a breed you train, 'a professional dog handler tells us, 'He's like a human. You befriend him.' The dense, harsh coat is described as 'neat but shaggy' and comes in several colors; the gait is light and confident. They can be willful and domineering, but mostly Affens are loyal, affectionate, and always entertaining. Affen people say they love being owned by their little monkey dogs.",
  "border collie" =>
    "A remarkably bright workaholic, the Border Collie is an amazing dog' maybe a bit too amazing for owners without the time, energy, or means to keep it occupied. These energetic dogs will settle down for cuddle time when the workday is done. Borders are athletic, medium-sized herders standing 18 to 22 inches at the shoulder. The overall look is that of a muscular but nimble worker unspoiled by passing fads. Both the rough coat and the smooth coat come in a variety of colors and patterns. The almond eyes are the focus of an intelligent expression' an intense gaze, the Border's famous 'herding eye', is a breed hallmark. On the move, Borders are among the canine kingdom's most agile, balanced, and durable citizens. The intelligence, athleticism, and trainability of Borders have a perfect outlet in agility training. Having a job to perform, like agility' or herding or obedience work' is key to Border happiness. Amiable among friends, they may be reserved with strangers.",
  "boxer" =>
    "Loyalty, affection, intelligence, work ethic, and good looks: Boxers are the whole doggy package. Bright and alert, sometimes silly, but always courageous, the Boxer has been among America's most popular dog breeds for a very long time. A well-made Boxer in peak condition is an awesome sight. A male can stand as high as 25 inches at the shoulder; females run smaller. Their muscles ripple beneath a short, tight-fitting coat. The dark brown eyes and wrinkled forehead give the face an alert, curious look. The coat can be fawn or brindle, with white markings. Boxers move like the athletes they are named for: smooth and graceful, with a powerful forward thrust. Boxers are upbeat and playful. Their patience and protective nature have earned them a reputation as a great dog with children. They take the jobs of watchdog and family guardian seriously and will meet threats fearlessly. Boxers do best when exposed to a lot of people and other animals in early puppyhood.",
  "cocker spaniel" =>
    "The merry and frolicsome Cocker Spaniel, with his big, dreamy eyes and impish personality, is one of the world's best-loved breeds. They were developed as hunting dogs, but Cockers gained their wide popularity as all-around companions. Those big, dark eyes; that sweet expression; those long, lush ears that practically demand to be touched' no wonder the Cocker spent years as America's most popular breed. The Cocker is the AKC's smallest sporting spaniel, standing about 14 to 15 inches. The coat comes in enough colors and patterns to please any taste. The well-balanced body is sturdy and solid, and these quick, durable gundogs move with a smooth, easy gait. Cockers are eager playmates for kids and are easily trained as companions and athletes. They are big enough to be sporty, but compact enough to be portable. A Cocker in full coat rewards extra grooming time by being the prettiest dog on the block. These energetic sporting dogs love playtime and brisk walks.",
  "english bulldog" =>
    "Kind but courageous, friendly but dignified, the Bulldog is a thick-set, low-slung, well-muscled bruiser whose 'sourmug' face is the universal symbol of courage and tenacity. These docile, loyal companions adapt well to town or country. 

  # You can't mistake a Bulldog for any other breed. The loose skin of the head, furrowed brow, pushed-in nose, small ears, undershot jaw with hanging chops on either side, and the distinctive rolling gait all practically scream 'I'm a Bulldog!' The coat, seen in a variety of colors and patterns, is short, smooth, and glossy. Bulldogs can weigh up to 50 pounds, but that won't stop them from curling up in your lap, or at least trying to. But don't mistake their easygoing ways for laziness' Bulldogs enjoy brisk walks and need regular moderate exercise, along with a careful diet, to stay trim. Summer afternoons are best spent in an air-conditioned room as a Bulldog's short snout can cause labored breathing in hot and humid weather.",
  "great dane" =>
    "The easygoing Great Dane, the mighty 'Apollo of Dogs,' is a total joy to live with, but owning a dog of such imposing size, weight, and strength is a commitment not to be entered into lightly. This breed is indeed great, but not a Dane.

  As tall as 32 inches at the shoulder, Danes tower over most other dogs and when standing on their hind legs, they are taller than most people. These powerful giants are the picture of elegance and balance, with the smooth and easy stride of born noblemen. The coat comes in different colors and patterns, perhaps the best-known being the black-and-white patchwork pattern known as harlequin. Despite their sweet nature, Danes are alert home guardians. Just the sight of these gentle giants is usually enough to make intruders think twice. But those foolish enough to mistake the breed's friendliness for softness will meet a powerful foe of true courage and spirit. Patient with kids, Danes are people pleasers who make friends easily.",
  "irish terrier" =>
    "The Irish Terrier, 'Daredevil' of the Emerald Isle, is a bold, dashing, and courageous terrier of medium size. Known for his fiery red coat and a temperament to match, the Irish Terrier is stouthearted at work and tenderhearted at home. Irish Terriers are the prototype of a long-legged terrier. Standing about 18 inches at the shoulder, they're sturdy but lithe and graceful. Every line of the body is eye-catching, and the overall picture is beautifully balanced. The tight red coat is as fiery as the breed's temperament. ITs are a dog lover's delight: If your heart doesn't go pitty-pat at the sight of this Technicolor terrier framed against the vivid greens of the Irish countryside, forget dogs and buy a goldfish.",
  "norwich terrier" =>
    "Norwich Terriers are plucky little earthdogs named for their hometown in England. The old cliche 'a big dog in a small package' was coined for breeds like the Norwich, who can be oblivious to the fact that they are just 10 inches tall.

  Standing no more than 10 inches at the shoulder and weighing about 12 pounds, Norwich are among the smallest working terriers. Beneath the hard, wiry coat is a stocky, substantial dog. Norwiches are toy-sized but are not satin-pillow dogs' they were originally bred as tough and fearless ratters. They are distinguished from their doggy doppelganger, the Norfolk Terrier, by their erect, pointed ears. Happy-go-lucky, fearless, and sometimes even bossy, Norwiches are energetic enough to play fetch all day, but affectionate enough to enjoy hours of lap time with their favorite human. Short, positive training sessions work best with this clever but sometimes stubborn breed. Three words convey the overall dog: cute, cuter, and cutest.",
  "pomeranian" =>
    "The tiny Pomeranian, long a favorite of royals and commoners alike, has been called the ideal companion. The glorious coat, smiling, foxy face, and vivacious personality have helped make the Pom one of the world's most popular toy breeds.  The Pomeranian combines a tiny body (no more than seven pounds) and a commanding big-dog demeanor. The abundant double coat, with its frill extending over the chest and shoulders, comes in almost two dozen colors, and various patterns and markings, but is most commonly seen in orange or red. Alert and intelligent, Pomeranians are easily trained and make fine watchdogs and perky pets for families with children old enough to know the difference between a toy dog and a toy. Poms are active but can be exercised with indoor play and short walks, so they are content in both the city and suburbs. They will master tricks and games with ease, though their favorite activity is providing laughs and companionship to their special human.",
  "shetland sheepdog" =>
    "The Shetland Sheepdog, also known as the Sheltie, is an extremely intelligent, quick, and obedient herder from Scotland's remote and rugged Shetland Islands. Shelties bear a strong family resemblance to their bigger cousin, the Collie. The Shetland Sheepdog is a small, active, and agile herding dog standing between 13 and 16 inches at the shoulder. The long coat is harsh and straight, with a dense undercoat, and comes in black, blue merle, and sable, with white markings. The coat, along with a long, wedge-shaped head; small, three-quarter erect ears; and deep-chested, level-backed torso, give Shelties the look of a rough-coated Collie in miniature. Bright and eager Shelties are easy trainers and world-class competitors in obedience, agility, and herding trials. They are sensitive and affectionate family dogs, highly in tune with the mood of the household. They like to bark and tend to be reserved toward strangers' two qualifications of an excellent watchdog."
}

image_paths = Path.wildcard("priv/repo/images/**")

for image_path <- image_paths do
  filename = Path.basename(image_path)

  extname = Path.extname(filename)
  breed = Path.rootname(filename, extname) |> String.replace("_", " ")
  s3_path = S3.get_s3_path("dog", filename)

  dog = %Dog{
    breed: breed,
    description: Map.fetch!(breed_to_description_map, breed),
    image_url: S3.s3_url(s3_path)
  }

  Repo.insert!(dog)
end
