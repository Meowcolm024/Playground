{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Haskell.Practical.KMean where

import           Data.List                      ( minimumBy )
import qualified Data.Map                      as M

class Ord v => Vector v where
  distance :: v -> v -> Double
  centroid :: [v] -> v

class Vector v => Vectorizable e v where
  toVector :: e -> v

instance Vector (Double, Double) where
    distance (a, b) (c, d) = sqrt $ (c - a) ** 2 + (d - b) ** 2
    centroid lst =
        let (u, v) = foldr (\(a, b) (c, d) -> (a + b, c + d)) (0, 0) lst
            n      = fromIntegral $ length lst
        in  (u / n, v / n)

instance Vectorizable (Double, Double) (Double, Double) where
    toVector = id

clusterAssignmentPhase
    :: (Ord v, Vector v, Vectorizable e v) => [v] -> [e] -> M.Map v [e]
clusterAssignmentPhase centroids points =
    let initialMap = M.fromList $ zip centroids (repeat [])
    in  foldr
            (\p m ->
                let chosenC = minimumBy (compareDistance p) centroids
                in  M.adjust (p :) chosenC m
            )
            initialMap
            points
  where
    compareDistance p x y =
        compare (distance x $ toVector p) (distance y $ toVector p)

newCentroidPhase :: (Vector v, Vectorizable e v) => M.Map v [e] -> [(v, v)]
newCentroidPhase = M.toList . fmap (centroid . map toVector)

shouldStop :: Vector v => [(v, v)] -> Double -> Bool
shouldStop centroids threshold =
    foldr (\(x, y) s -> s + distance x y) 0.0 centroids < threshold

kMeans
    :: (Vector v, Vectorizable e v)
    => (Int -> [e] -> [v])      -- initialization function
    -> Int                      -- number of centroids
    -> [e]                      -- info
    -> Double                   -- threshold
    -> [v]
kMeans i k points = kMeans' (i k points) points

kMeans' :: (Vector v, Vectorizable e v) => [v] -> [e] -> Double -> [v]
kMeans' centroids points threshold =
    let assignments     = clusterAssignmentPhase centroids points
        oldNewCentroids = newCentroidPhase assignments
        newCentroids    = map snd oldNewCentroids
    in  if oldNewCentroids `shouldStop` threshold
            then newCentroids
            else kMeans' newCentroids points threshold

initialzeSimple :: Int -> [e] -> [(Double, Double)]
initialzeSimple 0 _ = []
initialzeSimple n v =
    (fromIntegral n, fromIntegral n) : initialzeSimple (n - 1) v

-- * tests

info :: [(Double, Double)]
info = [(1, 1), (1, 2), (4, 4), (4, 5)]

-- >>> result
-- [(1.0,1.5),(4.0,4.5)]
result :: [(Double, Double)]
result = kMeans initialzeSimple 2 info 0.001
