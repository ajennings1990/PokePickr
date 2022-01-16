extension TrainerGameCoordinator: TrainerGameViewControllerDelegate {
  
  func viewControllerViewWillAppear(_ viewController: TrainerGameViewController) {
    loadPokemonData(for: viewController)
  }
  
  func viewControllerDidMakeSelection(_ viewController: TrainerGameViewController, selection: PokemonGameInfo) {
    guard selections.count < selectionTotal - 1 else {
      calculateResult(for: viewController)
      return
    }
    selections.append(selection)
    loadPokemonData(for: viewController)
  }
  
}
