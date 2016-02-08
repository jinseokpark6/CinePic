# Week 1 - *CinePic*

**CinePic** is a movie viewer application for iOS.

Submitted by: **Jin Seok Park**

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can view a list of movies currently playing in theaters from The Movie Database.
* [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
* [X] The movie poster is available by appending the returned poster_path to https://image.tmdb.org/t/p/w342.
* [X] User sees a loading state while waiting for the movies API (you can use any 3rd party library available to do this).
* [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

* [X] User sees an error message when there's a networking error.
* [X] Movies are displayed using a CollectionView instead of a TableView.
* [X] User can search for a movie.
* [X] All images fade in as they are loading.

The following **additional** features are implemented:

- [X] User can press cell to view the title and overview of the corresponding movie.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/dz4wPtq.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
- Tried to implement a custom view for the reloading view but encountered difficulties in making it look fluid and natural.

## License

    Copyright [2016] [Jin Seok Park]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.



# Project 2 - *CinePic*

**CinePic** is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **7** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can view movie details by tapping on a cell.
- [X] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [X] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [X] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [X] Customize the navigation bar.

The following **additional** features are implemented:

- [X] Created Movie class to pass and organize objects more efficiently.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. UI/UX - better user experience in the DetailViewController
2. Include more information - ratings, release date, etc

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/se6osVD.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

    Copyright [2016] [Jin Seok Park]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
