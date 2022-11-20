#!/bin/bash

# variable to stop the script after 10 matches
ten_post_limit=0; 

# script awk per prendere i profileId dei primi 10 post con descrizione > 100
awk -v ten_post_limit=$ten_post_limit '{
  if (length($8)>100){
	if ($4 == -1){
	print User not found;
	}
	else {print $4};
      ten_post_limit++;
  }
  if (ten_post_limit==10)
    exit;
}' instagram_posts.csv > output_profile.txt 

output_profile='output_profile.txt'
all_ig_prof='instagram_profiles.csv'

# creates a txt file and writes title of columns of csv file
head -n1 instagram_profiles.csv | tr , '\n' > output_result.txt 

# finds profiles id in the output_profile list
grep -f <(tr ',' '\n' < "${output_profile}") "${all_ig_prof}" >> output_result.txt 

# removes output_profile list
rm output_profile.txt 

# print of matching profiles as output
while read -r line; do echo $line; printf "\n"; done < output_result.txt 
