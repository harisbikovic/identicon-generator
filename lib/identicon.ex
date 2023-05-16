defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
    hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
      |> filter_odd_squares

    %Identicon.Image{image | grid: grid}
    |> build_pixel_map
    |> draw_image
    |> save_image
  end

  def save_image(binary_image) do
    File.write("identicon_image", binary_image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill_color = :egd.color(color)

    Enum.each(pixel_map, fn {point1, point2} ->
      :egd.filledRectangle(image, point1, point2, fill_color)
    end)

    :egd.render(image)

  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map(grid, fn {_, index} ->
      x1 = rem(index, 5)*50
      y1 = div(index, 5)*50

      point1 = {x1, y1}
      point2 = {x1+50, y1+50}
      {point1, point2}
    end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(grid) do
    Enum.filter(grid, fn {x,_} -> rem(x,2)==0 end)
  end

  def mirror_row([f, s, _] = row) do
    row ++ [s, f]
  end

  def pick_color(%Identicon.Image{hex: [red, green, blue | _]} = image) do
    %Identicon.Image{image | color: {red, green, blue}}
  end

  def hash_input(input) do
      hex = :crypto.hash(:md5, input)
      |> :binary.bin_to_list

      %Identicon.Image{hex: hex}
  end
end
