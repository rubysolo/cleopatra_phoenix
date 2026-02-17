defmodule Storybook.CoreComponents do
  use PhoenixStorybook.Index

  def folder_open?, do: true

  def entry("accordion"), do: [icon: {:fa, "bars-staggered", :thin}]
  def entry("alert"), do: [icon: {:fa, "triangle-exclamation", :thin}]
  def entry("avatar"), do: [icon: {:fa, "circle-user", :thin}]
  def entry("back"), do: [icon: {:fa, "circle-left", :thin}]
  def entry("badge"), do: [icon: {:fa, "tag", :thin}]
  def entry("breadcrumb"), do: [icon: {:fa, "ellipsis", :thin}]
  def entry("button"), do: [icon: {:fa, "rectangle-ad", :thin}]
  def entry("card"), do: [icon: {:fa, "square", :thin}]
  def entry("drawer"), do: [icon: {:fa, "sidebar", :thin}]
  def entry("dropdown"), do: [icon: {:fa, "caret-down", :thin}]
  def entry("error"), do: [icon: {:fa, "circle-exclamation", :thin}]
  def entry("flash"), do: [icon: {:fa, "bolt", :thin}]
  def entry("header"), do: [icon: {:fa, "heading", :thin}]
  def entry("icon"), do: [icon: {:fa, "icons", :thin}]
  def entry("input"), do: [icon: {:fa, "input-text", :thin}]
  def entry("list"), do: [icon: {:fa, "list", :thin}]
  def entry("modal"), do: [icon: {:fa, "window-restore", :thin}]
  def entry("pagination"), do: [icon: {:fa, "arrow-right-arrow-left", :thin}]
  def entry("progress"), do: [icon: {:fa, "bars-progress", :thin}]
  def entry("separator"), do: [icon: {:fa, "minus", :thin}]
  def entry("skeleton"), do: [icon: {:fa, "ghost", :thin}]
  def entry("table"), do: [icon: {:fa, "table", :thin}]
  def entry("tabs"), do: [icon: {:fa, "folder", :thin}]
  def entry("tooltip"), do: [icon: {:fa, "comment", :thin}]
end
