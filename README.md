# Gilded rose tech test
## Spec

This is a well known kata developed by [Terry Hughes](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/). This is commonly used as a tech test to assess a candidate's ability to read, refactor and extend legacy code.

Here is the text of the kata:

*"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

All items have a `SellIn` value which denotes the number of days we have to sell the item. All items have a Quality value which denotes how valuable the item is. At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- “Aged Brie” actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
- “Backstage passes”, like aged brie, increases in Quality as it’s `SellIn` value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

* “Conjured” items degrade in Quality twice as fast as normal items

Feel free to make any changes to the `UpdateQuality` method and add any new code as long as everything still works correctly. However, do not alter the Item class or Items property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t believe in shared code ownership (you can make the `UpdateQuality` method and Items property static if you like, we’ll cover for you)."*

## The brief:

Choose [legacy code](https://github.com/emilybache/GildedRose-Refactoring-Kata) (translated by Emily Bache) in the language of your choice. The aim is to practice good design in the language of your choice. Refactor the code in such a way that adding the new "conjured" functionality is easy.

You don't need to clone the repo if you don't want to. Feel free to copy [the ruby code](https://github.com/emilybache/GildedRose-Refactoring-Kata/blob/main/ruby/gilded_rose.rb) into a new folder and write your tests from scratch.

HINT: Test first FTW!

## Self-assessment

Once you have completed the challenge and feel happy with your solution, here's a form to help you reflect on the quality of your code:
https://docs.google.com/forms/d/e/1FAIpQLSdi4pNXpobmSpdw8T0dml4m6NrQ71IdEzwO5hA9v9_ZzmW7MA/viewform

## Planning

### Approach
- read through current codebase
- draft input/ output for each type of item
- write tests for each input / output
  - check these pass to confirm I've understood the codebase correctly
- refactor the current codebase to improve:
  - readability
  - separation of concerns
  - DRY
  - easy to change and update
  - ensure all tests passing with each refactored area
- add on the new functionality using TDD approach
- refactor further where possible
- create a feature test

### Drafting out the interactions
- item instance
  - `name` value: string - name of the item
  - `sell_in` value: int - denotes the number of days we have to sell the item
  - `quality` value: int - denotes how valuable the item is
  
- At the end of each day:
  - DEFAULT:
    - `sell_in` 
      - value drops by one
    - `quality` 
      - value drops by one 
      - upper limit of 50
      - lower limit of 0
      - `sell_in` < 0 => `quality` value degrades twice as fast
  - “Aged Brie” 
    - `sell_in` 
      - value drops by one
    - `quality` 
      - value increases by one
  - “Sulfuras”
    - `sell_in` 
      - doesn't change
    - `quality` 
      - doesn't change
  - “Backstage passes”
    - `sell_in` 
      - value drops by one
    - `quality` 
      - value increases by one when `sell_in` > 10
      - value increases by two when `sell_in` <= 10
      - value increases by three when `sell_in` <= 5
      - value drops to zero when `sell_in` < 0
  - “Conjured”
     - `sell_in` 
      - value drops by one
    - `quality` 
      - value drops by two
## Challenges

- how can I double item instances when their values get changed throughout the update_quality method?
  - stubbing this feels like I would be automatically passing the tests with my stub?

